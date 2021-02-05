class Appointment::CancelRequestController < ApplicationController

  def create
    UserDetail.find_by(eduPersonPrincipalName: cas_user).update(hasAppointment: false)
    Appointment.where(eduPersonPrincipalName: cas_user).where.not(status: "Closed").first.update(status: "Closed", notes: "Student Cancel Appt: " + params["reason"])
    flash[:success] = "You have successfully cancel this appointment."
    # TODO: Email or Slack
    redirect_to student_index_url
  end
end
