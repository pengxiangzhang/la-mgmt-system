class Appointment::LaAcceptController < ApplicationController
  before_action :check_la
  def create
    appointment = Appointment.find_by(id: params['id'])
    appointment.la_eduPersonPrincipalName = cas_user
    appointment.la_accept_time = Time.now
    appointment.status = "Accepted"
    appointment.save
    flash[:success] = "Successfully accept this appointment."
    redirect_to la_index_url
  end
  end