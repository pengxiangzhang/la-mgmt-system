class EmailMailer < ApplicationMailer
  def new_applicant(application)
    email = SystemValue.find_by(name: 'application_email').value
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    mail to: email, subject: 'New Application Submitted [LA Program]'
  end

  def thank_applying(application)
    email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    mail to: email, subject: 'Thank you for apply to the LA program'
  end
end
