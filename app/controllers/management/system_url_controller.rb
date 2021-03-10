class Management::SystemUrlController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'system_url')
    if @url.blank?
      flash[:error] = 'You must provide an URL.'
      redirect_to admin_management_url
    else
      @url.value = params['system_url']
      @url.save
      flash[:success] = 'Successfully change system url to ' + params['system_url'] + '.'
      redirect_to admin_management_url
    end
  end
end