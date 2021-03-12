class Appointment::EndApptController < ApplicationController
  before_action :check_la

  def create
    @appointment = Appointment.find_by({ id: params['id'] })
    if !((@appointment.status == 'Started') || (@appointment.la_eduPersonPrincipalName != cas_user) || (@appointment.eduPersonPrincipalName != cas_user))
      flash[:error] = 'You are not allowed to do this action'
      redirect_back(fallback_location: root_path)
    else
      UserDetail.find_by(eduPersonPrincipalName: @appointment.eduPersonPrincipalName).update(hasAppointment: false)
      @appointment.status = 'Closed'
      @appointment.endTime = Time.now
      @appointment.close_reason = "Appointment ended by: #{cas_name}"
      @appointment.save
      begin
        send_interaction(@appointment.eduPersonPrincipalName, @appointment.la_eduPersonPrincipalName, @appointment.class_id, 'appointment')
        flash[:success] = 'Appointment Ended'
      rescue StandardError
        flash[:error] = "User not found at the Survey system: #{@appointment.eduPersonPrincipalName}. Please report this to the admin."
      end
      redirect_back(fallback_location: root_path)
    end
  end
end
