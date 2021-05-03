class ContactController < ApplicationController

  def create
    if cas_user
      name = cas_name
      username = cas_user
    else
      name = 'Not log in'
      username = 'anonymous'
    end
    if is_human(params['h-captcha-response'])
      EmailMailer.contact(name, username, params).deliver_now
      ActionLogger.info("[User: #{username}|IP:#{request.ip}] submit contact form.")
      flash[:success] = 'We have received your inquiry, Thank you for your time.'
    else
      flash[:danger] = 'Please finish the captcha.'
    end
    redirect_to home_contact_url
  end
end
