class Hiring::ApplicationEmailController < ApplicationController
  def create
    @email = SystemValue.find_by(name: 'application_email')
    @email.value = params['hiring_email']
    @email.save
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
