require 'rufus-scheduler'
return if defined?(Rails::Console) || Rails.env.test? || File.split($0).last == 'rake'

Rufus::Scheduler.singleton.every '30s' do
  request = Appointment.where(status: "Requested")
  request.each do |app|
    if app.datetime.nil?
      if app.created_at.to_time + 24.hours < Time.now
        app.status = "Closed"
        app.notes = "ASAP request time out at " + Time.now.to_s
        UserDetail.find_by(eduPersonPrincipalName: app.eduPersonPrincipalName).update(hasAppointment: false)
        app.save
        # TODO: Email to student
      end
    else
      if app.datetime.to_time - 15.minutes < Time.now
        app.status = "Closed"
        app.notes = "Scheduled request time out at " + Time.now.to_s
        UserDetail.find_by(eduPersonPrincipalName: app.eduPersonPrincipalName).update(hasAppointment: false)
        app.save
        # TODO: Email to student
      end
    end
  end
end

