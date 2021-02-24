class Appointment::LaAcceptController < ApplicationController
  before_action :check_la

  def create
    appointment = Appointment.find_by({ id: params['id'] })
    datetime = (params["date"] + " " + params["time"] + " CST").to_time
    if datetime.past?
      flash[:error] = "The time is in the past."
      redirect_to la_index_url
    elsif appointment.status == "Requested"
      appointment.la_eduPersonPrincipalName = cas_user
      appointment.la_accept_time = Time.now
      appointment.location = params['location']
      if !params['note'].empty?
        appointment.notes = params['note']
      end
      if appointment.datetime.nil?
        appointment.datetime = datetime
      end
      appointment.status = "Accepted"
      appointment.save
      EmailMailer.appointment_accepted(appointment.class_id, appointment.the_method, appointment.datetime, appointment.duration.to_s, appointment.displayName, UserDetail.find_by(eduPersonPrincipalName: appointment.la_eduPersonPrincipalName).DisplayName, appointment.location, "Your Appointment Has Been Accepted", appointment.notes, appointment.email)
      EmailMailer.appointment_accepted(appointment.class_id, appointment.the_method, appointment.datetime, appointment.duration.to_s, appointment.displayName, UserDetail.find_by(eduPersonPrincipalName: appointment.la_eduPersonPrincipalName).DisplayName, appointment.location, "You Have Accept the Following Appointment", appointment.notes, cas_email)
      flash[:success] = "Successfully accept this appointment."
      redirect_to la_index_url
    else
      flash[:error] = "This request no longer exist."
      redirect_to la_index_url
    end
  end
end