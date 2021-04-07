class ContactController < ApplicationController

  def create
    if cas_user
      name = cas_name
      username = cas_user
    else
      name = 'Not log in'
      username = 'anonymous'
    end
    if verify_hcaptcha
      EmailMailer.contact(name, username, params).deliver_now
      ActionLogger.info("[User: #{username}|IP:#{request.ip}] submit contact form.")
      flash[:success] = 'We have received your inquiry, Thank you for your time.'
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = 'Please finish the captcha.'
    end
  end
end
