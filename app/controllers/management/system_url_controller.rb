class Management::SystemUrlController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'system_url')
    if @url.blank?
      flash[:info] = 'You must provide an URL.'
    else
      @url.value = params['system_url']
      @url.save
      flash[:success] = "Successfully change system url to #{params['system_url']}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|System Url] Change survey url to '#{params['system_url']}'.")
    end
    redirect_to admin_management_url
  end
end