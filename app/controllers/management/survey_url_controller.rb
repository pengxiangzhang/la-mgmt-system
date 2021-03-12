class Management::SurveyUrlController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'survey_url')
    if @url.blank?
      flash[:error] = 'You must provide an URL.'
      redirect_to admin_management_url
    else
      @url.value = params['survey_url']
      @url.save
      flash[:success] = "Successfully change survey url to #{params['survey_url']}."
      redirect_to admin_management_url
    end
  end
end