class Hiring::InterviewLocationController < ApplicationController
  before_action :check_admin

  def create
    @interview_location = SystemValue.find_by(name: 'interview_location')
    @interview_location.value = params['interview_location']
    @interview_location.save
    flash[:success] = "Successfully change the interview location to #{params['interview_location']}."
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Change Interview Location] Update interview location to '#{params['interview_location']}'.")
    redirect_to admin_management_url
  end
end
