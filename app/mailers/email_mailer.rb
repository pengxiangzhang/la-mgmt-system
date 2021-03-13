class EmailMailer < ApplicationMailer

  def contact(name, username, submit)
    @name = name
    @username = username
    @submit = submit
    email = SystemValue.find_by(name: 'admin_email').value
    mail to: email, subject: 'Message From Your Website[Learning Assistant Program]'
  end

  def new_applicant(application)
    email = SystemValue.find_by(name: 'admin_email').value
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    mail to: email, subject: 'New Application Submitted [Learning Assistant Program]'
  end

  def thank_applying(application)
    email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    mail to: email, subject: 'Thank You for Applying to the Learning Assistant Program'
  end

  def new_accept(application)
    email = SystemValue.find_by(name: 'admin_email').value
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    mail to: email, subject: 'Someone Accepted the Position Offer [Learning Assistants Program]'
  end

  def scheduled_applicant(application)
    @index_Page = SystemValue.find_by(name: 'system_url').value
    email = application[:Email]
    @admin_email = SystemValue.find_by(name: 'admin_email').value
    @name = application[:Name]
    @time = application[:Interview_Time].strftime('%m/%d/%Y %I:%M %P')
    start_time = @time.to_time.strftime('%-d/%-m/%Y %H:%M:%S')
    end_time = (@time.to_time + 30.minute).strftime('%-d/%-m/%Y %H:%M:%S')
    summary = 'LA Program Application Interview'
    description = "Contact Email: #{@admin_email}."
    @location = SystemValue.find_by(name: 'interview_location').value
    ics = ics(start_time, end_time, summary, email, @admin_email, description, @location)
    mail.attachments['invite.ics'] = { content_type: 'text/calendar; charset=UTF-8; method=REQUEST', encoding: '7bit', content: ics.to_ical }
    mail to: email, subject: 'Learning Assistants Program Interview Confirmation'
  end

  def new_scheduled_applicant(application)
    email = SystemValue.find_by(name: 'admin_email').value
    @student_email = application[:Email]
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @name = application[:Name]
    @course = application[:Course]
    @time = application[:Interview_Time].strftime('%m/%d/%Y %I:%M %P')
    start_time = @time.to_time.strftime('%-d/%-m/%Y %H:%M:%S')
    end_time = (@time.to_time + 30.minute).strftime('%-d/%-m/%Y %H:%M:%S')
    summary = "LA Program Application Interview with #{@name}"
    description = "Contact Email: #{@student_email}."
    @location = SystemValue.find_by(name: 'interview_location').value
    ics = ics(start_time, end_time, summary, email, application[:Name], description, @location)
    mail.attachments['invite.ics'] = { content_type: 'text/calendar; charset=UTF-8; method=REQUEST', encoding: '7bit', content: ics.to_ical }
    mail to: email, subject: 'Someone Scheduled for Interview [Learning Assistant Program]'
  end

  def template(to, cc, subject, body)
    @content = body
    mail to: to, cc: cc, subject: subject
  end

  def appointment_confirm(course, visit, time, duration, email)
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @course = course
    @visit = visit
    @time = time
    @duration = duration
    mail to: email, subject: 'Request Received[Learning Assistant Program]'
  end

  def appointment_cancel(course, visit, time, duration, name, by, la, reason, email)
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @course = course
    @visit = visit
    @time = time
    @duration = duration
    @name = name
    @by = by
    @la = la
    @reason = reason
    mail to: email, subject: 'Your Appointment Had Been Canceled[Learning Assistant Program]'
  end

  def timeout(course, visit, time, duration, name, email)
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @course = course
    @visit = visit
    @time = time
    @duration = duration
    @name = name
    mail to: email, subject: 'Your Appointment Has Timed Out[Learning Assistant Program]'
  end

  def appointment_accepted(course, visit, time, duration, name, la, location, subject, notes, email)
    @index_Page = SystemValue.find_by(name: 'system_url').value
    @course = course
    @visit = visit
    @time = time
    @duration = duration
    @name = name
    @la = la
    @location = location
    @notes = notes
    mail to: email, subject: "#{subject}[Learning Assistant Program]"
  end

  def ics(dtstart, dtend, summary, organizer, attendee, description, location)
    cal = Icalendar::Calendar.new
    cal.timezone do |e|
      e.tzid = 'America/Chicago'
    end

    cal.event do |e|
      e.dtstart = DateTime.parse(dtstart)
      e.dtend = DateTime.parse(dtend)
      e.summary = summary
      e.organizer = Icalendar::Values::CalAddress.new("#{organizer}", cn: EMAIL_SENDER_NAME)
      e.attendee = ["mailto:#{attendee}"]
      e.description = description
      e.location = location
    end
    cal.append_custom_property('METHOD', 'REQUEST')
    cal
  end
end