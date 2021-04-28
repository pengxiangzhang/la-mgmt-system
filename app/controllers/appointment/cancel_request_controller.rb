class Appointment::CancelRequestController < ApplicationController

  def create
    appt = Appointment.where({ eduPersonPrincipalName: cas_user }).where.not(status: 'Closed').first
    if appt.nil?
      flash[:error] = 'Appointment not found.'
    else
      UserDetail.find_by({ eduPersonPrincipalName: cas_user }).update(hasAppointment: false)
      if appt.status != 'Requested'
        la = UserDetail.find_by(eduPersonPrincipalName: appt.la_eduPersonPrincipalName)
        message = "Message for`#{la.DisplayName}`\nThe following appointment has been canceled:\nClass: #{appt.class_id}\nMethod: #{appt.the_method}\nDuration: #{appt.duration.to_s} minutes\nWhen: #{appt.datetime.strftime('%m/%d/%Y %I:%M %P')}\nReason: #{params['reason']}\nVisit #{SystemValue.find_by(name: 'system_url').value} for more details."
        EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, appt.displayName, 'la.displayName', params['reason'], appt.email).deliver_now
        EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, appt.displayName, 'la.displayName', params['reason'], la.Email).deliver_now
      elsif appt.datetime.nil?
        message = "The following appointment has been canceled:\nClass: #{appt.class_id}\nMethod: #{appt.the_method}\nDuration: #{appt.duration.to_s} minutes\nWhen: As Soon As Possible\nVisit #{SystemValue.find_by(name: 'system_url').value} for more details."
        EmailMailer.appointment_cancel(appt.class_id, appt.the_method, 'As Soon As Possible', appt.duration.to_s, appt.displayName, appt.displayName, 'Not Assign Yet', params['reason'], appt.email).deliver_now
      else
        message = "The following appointment has been canceled:\nClass: #{appt.class_id}\nMethod: #{appt.the_method}\nDuration: #{appt.duration.to_s} minutes\nWhen: #{appt.datetime.strftime('%m/%d/%Y %I:%M %P')}\nVisit #{SystemValue.find_by(name: 'system_url').value} for more details."
        EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, appt.displayName, 'Not Assign Yet', params['reason'], appt.email).deliver_now
      end
      send_slack(Course.find_by(course_name: appt.class_id).slack, message)
      flash[:success] = 'You have successfully cancel this appointment.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Student Cancel Request] Student Cancel Appointment ID: '#{appt.id}'.")
      appt.status = 'Closed'
      appt.close_reason = "Student(#{cas_name}) cancel appointment: #{params['reason']}. At #{Time.now.strftime('%m/%d/%Y %I:%M %P')}"
      appt.endTime = Time.now
      appt.save

    end
    redirect_to student_index_url
  end
end
