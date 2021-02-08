class Appointment::LaAcceptController < ApplicationController
  before_action :check_la

  def create
    appointment = Appointment.find_by(id: params['id'])
    if appointment.status == "Requested"
      appointment.la_eduPersonPrincipalName = cas_user
      appointment.la_accept_time = Time.now
      appointment.location = params['location']
      if !params['note'].empty?
        appointment.note = params['note']
      end
      if appointment.datetime.nil?
        datetime = DateTime.strptime(params["date"] + " " + params["time"] + " CST", "%Y-%m-%d %H:%M %Z")
        appointment.datetime = datetime
      end
      appointment.status = "Accepted"
      appointment.save
      # TODO: Email
      flash[:success] = "Successfully accept this appointment."
      redirect_to la_index_url
    else
      flash[:error] = "This request no longer exist."
      redirect_to la_index_url
    end
  end
end