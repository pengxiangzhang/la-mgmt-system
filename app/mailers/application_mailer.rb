class ApplicationMailer < ActionMailer::Base
  default :from => EMAIL_SENDER_NAME + ' <' + EMAIL_SENDER + '>'
  layout 'mailer'
end
