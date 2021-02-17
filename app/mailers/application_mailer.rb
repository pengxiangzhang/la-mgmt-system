class ApplicationMailer < ActionMailer::Base
  default :from => EMAIL_RECIPIENT,
          :reply_to => SystemValue.find_by(name: 'application_email').try(:value)
  layout 'mailer'
end
