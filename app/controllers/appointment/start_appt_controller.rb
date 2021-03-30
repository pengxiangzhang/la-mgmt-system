class Appointment::StartApptController < ApplicationController
  before_action :check_la

  def create
    @appointment = Appointment.find_by({ id: params['id'] })
    if @appointment.status != 'Accepted' || @appointment.la_eduPersonPrincipalName != cas_user || @appointment.eduPersonPrincipalName != cas_user
      flash[:info] = 'You are not allowed to do this action'
      render json: {}, status: 400
    else
      @appointment.status = 'Started'
      @appointment.startTime = Time.now
      @appointment.save
      flash[:success] = 'Appointment Started'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Start Appointment] Appointment start for ID: '#{@appointment.id}'.")
      render json: {}, status: 200
    end
  end
end
