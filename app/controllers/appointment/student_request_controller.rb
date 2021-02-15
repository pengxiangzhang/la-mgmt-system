class Appointment::StudentRequestController < ApplicationController

  def create
    user = UserDetail.find_by(eduPersonPrincipalName: cas_user)
    if !user.hasAppointment
      if (params['time'].empty? && params['now'].nil?) || (params['date'].empty? && params['now'].nil?)
        flash[:error] = "You must specify a time or submit an As Soon As Possible request"
        redirect_to student_index_url
      else
        if params['now']
          message = "Someone request an imminent request for " + params['class_id'] + ":\nMethod: " + params['method'] + "\nDuration: " + params['duration'] + "minutes\nWhen: As Soon As Possible\nVisit " + SystemValue.find_by(name: 'system_url').value + " for more detail."
          user.update(hasAppointment: true)
          Appointment.new({ eduPersonPrincipalName: cas_user, displayName: cas_name, email: cas_email, class_id: params['class_id'], the_method: params['method'], duration: params['duration'], status: "Requested" }).save
          # TODO uncomment before deploy
          # send_slack(Course.find_by(course_name: params['class_id']).slack, message)
          # EmailMailer.appointment_confirm(params['class_id'],params['method'],"As Soon As Possible",params['duration']+" minutes",cas_email).deliver_now
          # TODO: Uncomment before deploy
          flash[:success] = "You have successfully submit the request."
          redirect_to student_index_url
        else
          datetime = DateTime.strptime(params["date"] + " " + params["time"] + " Central Time", "%Y-%m-%d %I:%M %P %Z")
          if datetime < (Time.now + 15.minute)
            flash[:error] = "The time you entered is in the past or in the next 15 minutes. Please submit ASAP request if you need help now."
            redirect_to student_index_url
          elsif datetime.between?("08:00", "20:00")
            flash[:error] = "Time can only be 8:00 am to 8:00 pm."
            redirect_to student_index_url
          else
            message = "Someone schedule to visit an LA for " + params['class_id'] + ":\nMethod: " + params['method'] + "\nDuration: " + params['duration'] + "minutes\nWhen: " + params["date"] + " " + params["time"] + "\nVisit " + SystemValue.find_by(name: 'system_url').value + " for more detail."
            user.update(hasAppointment: true)
            Appointment.new({ eduPersonPrincipalName: cas_user, displayName: cas_name, email: cas_email, class_id: params['class_id'], datetime: datetime, the_method: params['method'], duration: params['duration'], status: "Requested" }).save
            # TODO uncomment before deploy
            # send_slack(Course.find_by(course_name: params['class_id']).slack, message)
            # EmailMailer.appointment_confirm(params['class_id'],params['method'],params["date"] + " " + params["time"],params['duration']+" minutes",cas_email).deliver_now
            # TODO: Uncomment before deploy
            flash[:success] = "You have successfully submit the request."
            redirect_to student_index_url
          end
        end
      end
    else
      flash[:error] = "You already have an appointment."
      redirect_to student_index_url
    end
  end
end
