class ApplicationMailer < ActionMailer::Base
  default :from =>'no-reply@lamgmt.ml',
          :reply_to => SystemValue.find_by(name: 'application_email').value,
          "Message-ID" => ->(v){"<#{Digest::SHA2.hexdigest(Time.now.to_i.to_s)}@lamgmt.ml>"}
  layout 'mailer'
end
