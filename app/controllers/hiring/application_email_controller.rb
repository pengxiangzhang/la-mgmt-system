class Hiring::ApplicationEmailController < ApplicationController
  before_action :check_admin

  def create
    @email = SystemValue.find_by(name: 'application_email')
    @email.value = params['hiring_email']
    @email.save
    redirect_to admin_hiring_url
  end
end
