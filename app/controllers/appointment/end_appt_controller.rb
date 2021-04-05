class Appointment::EndApptController < ApplicationController
  before_action :check_la

  def create
    @appointment = Appointment.find_by({ id: params['id'] })
    if !((@appointment.status == 'Started') || (@appointment.la_eduPersonPrincipalName != cas_user))
      flash[:info] = 'You are not allowed to do this action'
    else
      UserDetail.find_by(eduPersonPrincipalName: @appointment.eduPersonPrincipalName).update(hasAppointment: false)
      @appointment.status = 'Closed'
      @appointment.endTime = Time.now
      @appointment.close_reason = "Appointment ended by: #{cas_name}"
      @appointment.laFeedback = params['feedback']
      @appointment.save
      feedback = send_interaction(@appointment.eduPersonPrincipalName, @appointment.la_eduPersonPrincipalName, @appointment.class_id, 'appointment', params['recommend'])
      if feedback == true
        flash[:success] = 'Appointment Ended'
        ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|End Appointment] Appointment end for ID: '#{@appointment.id}'.")
      else
        flash[:info] = "User not found at the Survey system: #{@appointment.eduPersonPrincipalName}. Please report this to the admin."
        ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|End Appointment] Appointment end for ID: '#{@appointment.id}' No Student find in survey system.")
      end
    end
    redirect_to la_index_url
  end
end
