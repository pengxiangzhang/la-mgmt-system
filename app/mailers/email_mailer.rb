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
    mail to: email, subject: 'Thank you for your application at the LA program'
  end

  def interview_applicant(application)
    email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    mail to: email, subject: 'LA Program Invitation to Interview'
  end

  def offer_applicant(application)
    email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    mail to: email, subject: 'LA Program Job Offer'
  end

  def reject_applicant(application)
    email = application[:Email]
    @name = application[:Name]
    mail to: email, subject: 'Your Application to the LA Program Application'
  end

  def accept_applicant(application)
    email = application[:Email]
    @name = application[:Name]
    mail to: email, subject: 'Your Application to the LA Program Application'
  end

  def scheduled_applicant(application)
    email = application[:Email]
    @name = application[:Name]
    @time = application[:Interview_Time]
    mail to: email, subject: 'Your Scheduled Interview for the Learning Assitant Program'
  end

  def new_scheduled_applicant
    email = SystemValue.find_by(name: 'application_email').value
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    @time = application[:Interview_Time]
    mail to: email, subject: 'New Application Submitted [LA Program]'
  end

end
