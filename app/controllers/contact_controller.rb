class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if cas_user
      name = cas_name
      username = cas_user
    else
      name = 'Not log in'
      username = 'anonymous'
    end
    EmailMailer.contact(name, username, params).deliver_now
    flash[:success] = 'We have received your inquiry, Thank you for your time.'
    redirect_back(fallback_location: root_path)
  end
end
