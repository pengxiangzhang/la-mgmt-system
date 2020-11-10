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
    @admin_email = SystemValue.find_by(name: 'application_email').value
    @name = application[:Name]
    @time = application[:Interview_Time]
    start_time = @time.to_time.strftime("%-m/%-d/%Y %H:%M:%S")
    end_time = (@time.to_time + 30.minute).strftime("%-m/%-d/%Y %H:%M:%S")
    summary = "LA Program Application Interview"
    description = "Contact Email: " + @admin_email + "."
    @location = SystemValue.find_by(name: 'interview_location').value
    ics = ics(start_time, end_time, summary, email, description, @location)
    mail.attachments['interview.ics'] = {mime_type: 'text/calendar', content: ics.to_ical}
    mail to: email, subject: 'Your Scheduled Interview for the Learning Assistant Program'
  end

  def new_scheduled_applicant(application)
    email = SystemValue.find_by(name: 'application_email').value
    @student_email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    @time = application[:Interview_Time]
    start_time = @time.to_time.strftime("%-m/%-d/%Y %H:%M:%S")
    end_time = (@time.to_time + 30.minute).strftime("%-m/%-d/%Y %H:%M:%S")
    summary = "LA Program Application Interview with " + @name
    description = "Contact Email: " + @student_email + "."
    @location = SystemValue.find_by(name: 'interview_location').value
    ics = ics(start_time, end_time, summary, email, description, @location)
    mail.attachments['interview.ics'] = {mime_type: 'text/calendar', content: ics.to_ical}
    mail to: email, subject: 'New Application Submitted [LA Program]'
  end

  def ics(dtstart, dtend, summary, organizer, description, location)
    cal = Icalendar::Calendar.new
    cal.timezone do |e|
      e.tzid = "America/Chicago"
    end

    cal.event do |e|
      e.dtstart = DateTime.parse(dtstart)
      e.dtend = DateTime.parse(dtend)
      e.summary = summary
      e.organizer = "mailto:#{organizer}"
      e.organizer = Icalendar::Values::CalAddress.new("mailto:#{organizer}", cn: 'LA MGMT Team')
      e.description = description
      e.location = location
      e.ip_class = "PRIVATE"
    end
    return cal
  end
end
