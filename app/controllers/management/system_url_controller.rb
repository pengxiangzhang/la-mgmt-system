class Management::SystemUrlController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'system_url')
    @url.value = params['system_url']
    @url.save
    redirect_to admin_management_url
  end
end