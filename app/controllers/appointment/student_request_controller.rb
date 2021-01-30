class Appointment::StudentRequestController < ApplicationController

  def create
    if params['now']
      message = "Someone request an imminent request for " + params['class_id'] + ":\nMethod: " + params['method'] + "\nDuration: " + params['duration'] + "minutes\nWhen: As Soon As Possible\nVisit " + SystemValue.find_by(name: 'system_url').value + " for more detail."
    else
      message = "Someone schedule to visit an LA for " + params['class_id'] + ":\nMethod: " + params['method'] + "\nDuration: " + params['duration'] + "minutes\nWhen: " + params["date"] + " " + params["time"] + "\nVisit " + SystemValue.find_by(name: 'system_url').value + " for more detail."
    end

    send_slack("https://hooks.slack.com/services/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", message)
  end
end
