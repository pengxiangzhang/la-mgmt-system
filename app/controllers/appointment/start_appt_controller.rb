class Appointment::StartApptController < ApplicationController
  before_action :check_la

  def create
    @appointment = Appointment.find_by({ id: params['id'] })
    if @appointment.status != 'Accepted' || @appointment.la_eduPersonPrincipalName != cas_user || @appointment.eduPersonPrincipalName != cas_user
      flash[:error] = 'You are not allowed to do this action'
      redirect_back(fallback_location: root_path)
    else
      @appointment.status = 'Started'
      @appointment.startTime = Time.now
      @appointment.save
      flash[:success] = 'Appointment Started'
      redirect_back(fallback_location: root_path)
    end
  end
end
