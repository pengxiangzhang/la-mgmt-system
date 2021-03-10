class Management::AdminEmailController < ApplicationController
  before_action :check_admin

  def create
    @email = SystemValue.find_by(name: 'admin_email')
    @email.value = params['email']
    @email.save
    flash[:success] = "Successfully change admin email to #{params['email']}."
    redirect_to admin_management_url
  end
end
