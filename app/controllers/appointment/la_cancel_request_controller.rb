class Appointment::LaCancelRequestController < ApplicationController
  before_action :check_la

  def create
    appt = Appointment.where(id: params["ida"], la_eduPersonPrincipalName: cas_user).where.not(status: "Closed").first
    if appt.nil?
      p "haha " + params["ida"]
      flash[:error] = "Appointment not find"
      # TODO: Email or Slack
      redirect_to la_index_url
    else
      appt.update(status: "Closed", notes: "LA Cancel Appt: " + params["reason"], endTime: Time.now)
      UserDetail.find_by(eduPersonPrincipalName: appt.eduPersonPrincipalName).update(hasAppointment: false)
      flash[:success] = "You have successfully cancel this appointment."
      # TODO: Email or Slack
      redirect_to la_index_url
    end
  end
end
