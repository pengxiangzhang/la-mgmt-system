class Appointment::StudentRequestController < ApplicationController
  before_action :check_block

  def create
    user = UserDetail.find_by(eduPersonPrincipalName: cas_user)
    if !user.hasAppointment
      if (params['time'].empty? && params['now'].nil?) || (params['date'].empty? && params['now'].nil?)
        flash[:info] = 'You must specify a time or submit an As Soon As Possible request'
        redirect_to student_index_url
      elsif params['now']
        message = "<!here> Someone request an imminent request for #{params['class_id']}:\nMethod: #{params['method']}\nDuration: #{params['duration']} minutes\nWhen: As Soon As Possible\nDescription of problem: #{params['description']}\nVisit #{SystemValue.find_by(name: 'system_url').value} for more details."
        user.update(hasAppointment: true)
        Appointment.new({ eduPersonPrincipalName: cas_user, displayName: cas_name, email: cas_email, class_id: params['class_id'], the_method: params['method'], duration: params['duration'], description: params['description'], status: 'Requested' }).save
        send_slack(Course.find_by(course_name: params['class_id']).slack, message)
        EmailMailer.appointment_confirm(params['class_id'], params['method'], 'As Soon As Possible', "#{params['duration']} minutes", cas_email).deliver_now
        flash[:success] = 'You have successfully submit the request.'
        ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Student Appointment] Student request ASAP appointment.")
        redirect_to student_index_url
      else
        datetime = "#{params['date']} #{params['time']}".to_time
        if datetime.past?
          flash[:info] = 'The time you entered is in the past. Please check your input.'
          redirect_to student_index_url
        elsif datetime < (Time.now + 15.minute)
          flash[:info] = 'The time you entered is in the next 15 minutes. Please submit ASAP request if you need help now.'
          redirect_to student_index_url
        elsif datetime.hour < 8 || datetime.hour >= 20
          flash[:info] = 'Time can only be 8:00 am to 8:00 pm.'
          redirect_to student_index_url
        else
          message = "<!here> Someone schedule to visit an LA for #{params['class_id']}:\nMethod: #{params['method']}\nDuration: #{params['duration']} minutes\nWhen: #{params['date']} #{params['time']}\nDescription of problem: #{params['description']}\nVisit #{SystemValue.find_by(name: 'system_url').value} for more detail."
          user.update(hasAppointment: true)
          Appointment.new({ eduPersonPrincipalName: cas_user, displayName: cas_name, email: cas_email, class_id: params['class_id'], datetime: datetime, the_method: params['method'], duration: params['duration'], description: params['description'], status: 'Requested' }).save
          send_slack(Course.find_by(course_name: params['class_id']).slack, message)
          EmailMailer.appointment_confirm(params['class_id'], params['method'], "#{params['date']} #{params['time']}", "#{params['duration']}", cas_email).deliver_now
          if datetime.between?((Time.now + 15.minute), (Time.now + 45.minute))
            flash[:info] = 'You have successfully submitted the request. Notice that your appointment is in the next 45 minutes, You might want to submit an ASAP request if you need help now since the appointment will be expired 15 minutes before the appointment time.'
          else
            flash[:success] = 'You have successfully submit the request.'
          end

          ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Student Appointment] Student request schedule appointment.")
          redirect_to student_index_url
        end
      end
    else
      flash[:info] = 'You already have an appointment.'
      redirect_to student_index_url
    end
  end
end