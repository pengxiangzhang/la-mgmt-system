class Appointment::EndApptController < ApplicationController

  def create
    @appointment = Appointment.find_by({ id: params["id"] })
    if @appointment.status != "Started" || @appointment.la_eduPersonPrincipalName != cas_user || @appointment.eduPersonPrincipalName != cas_user
      flash[:error] = "You are not allowed to do this action"
      redirect_to :back
    else
      UserDetail.find_by(eduPersonPrincipalName: @appointment.eduPersonPrincipalName).update(hasAppointment: false)
      @appointment.status = "Closed"
      @appointment.endTime = Time.now
      @appointment.save
      flash[:success] = "Appointment Ended: TODO: Survey"
      # TODO: Survey
      redirect_back(fallback_location: root_path)
    end
  end
end
