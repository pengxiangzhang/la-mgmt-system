request = Appointment.where(status: 'Requested')
request.each do |app|
  if app.datetime.nil?
    if app.created_at.to_time + 24.hours < Time.now
      app.status = 'Closed'
      app.endTime = Time.now
      app.close_reason = "ASAP request time out at #{Time.now.strftime('%a, %m/%d/%y %I:%M %P')}"
      UserDetail.find_by(eduPersonPrincipalName: app.eduPersonPrincipalName).update(hasAppointment: false)
      app.save
      EmailMailer.timeout(app.class_id, app.the_method, Time.now.strftime('%a, %m/%d/%y %I:%M %P'), app.duration, app.name, app.email).deliver_now
      ActionLogger.info("[User: System|IP:System|Appointment Now Timeout] Now appointment timeout '#{app.id}'.")
    end
  else
    if app.datetime.to_time - 15.minutes < Time.now
      app.status = 'Closed'
      app.close_reason = "Scheduled request time out at #{Time.now.strftime('%a, %m/%d/%y %I:%M %P')}"
      app.endTime = Time.now
      UserDetail.find_by(eduPersonPrincipalName: app.eduPersonPrincipalName).update(hasAppointment: false)
      app.save
      EmailMailer.timeout(app.class_id, app.the_method, app.datetime.strftime('%a, %m/%d/%y %I:%M %P'), app.duration, app.displayName, app.email).deliver_now
      ActionLogger.info("[User: System|IP:System|Appointment Scheduled Timeout] Scheduled appointment timeout '#{app.id}'.")
    end
  end
end