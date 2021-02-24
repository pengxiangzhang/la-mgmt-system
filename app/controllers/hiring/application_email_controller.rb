class Hiring::ApplicationEmailController < ApplicationController
  before_action :check_admin

  def create
    #TODO: Change to admin email
    @email = SystemValue.find_by(name: 'application_email')
    @email.value = params['hiring_email']
    @email.save
    flash[:success] = "Successfully change admin email to " + params['hiring_email'] + "."
    redirect_to admin_hiring_url
  end
end
