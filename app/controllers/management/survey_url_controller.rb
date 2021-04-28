class Management::SurveyUrlController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'survey_url')
    if @url.blank?
      flash[:info] = 'You must provide an URL.'
    else
      @url.value = params['survey_url']
      @url.save
      flash[:success] = "Successfully change survey url to #{params['survey_url']}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Survey Url] Change survey url to '#{params['survey_url']}'.")
    end
    redirect_to admin_management_url
  end
end