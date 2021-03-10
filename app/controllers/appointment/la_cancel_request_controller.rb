class Appointment::LaCancelRequestController < ApplicationController
  before_action :check_la

  def create
    appt = Appointment.where({ id: params["ida"], la_eduPersonPrincipalName: cas_user }).where.not({ status: "Closed" }).first
    if appt.nil?
      flash[:error] = "Appointment not find"
      redirect_to la_index_url
    else
      appt.update({ status: "Closed", close_reason: "LA(" + cas_name + ") cancel appointment: " + params["reason"] + ". At " + Time.now.strftime("%m/%d/%Y %I:%M %P"), endTime: Time.now })
      UserDetail.find_by({ eduPersonPrincipalName: appt.eduPersonPrincipalName }).update({ hasAppointment: false })
      EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime("%m/%d/%Y %I:%M %P"), appt.duration.to_s, appt.displayName, cas_name, cas_name, params["reason"], cas_email).deliver_now
      EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime("%m/%d/%Y %I:%M %P"), appt.duration.to_s, appt.displayName, cas_name, cas_name, params["reason"], appt.email).deliver_now
      flash[:success] = "You have successfully cancel this appointment."
      redirect_to la_index_url
    end
  end
end