class Hiring::HiringCalendarController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'hiring_calendar')
    @url.value = params['hiring_calendar']
    @url.save
    flash[:success] = 'Successfully change the hiring calendar url.'
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Update Hiring Calendar] Update hiring calendar URL.")
    redirect_to admin_management_url
  end
end
