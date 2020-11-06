class StudentController < ApplicationController
  helper_method :get_date, :get_next_date, :hiring_calendar, :accept_application

  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end

  def check_student
    if user_type != "student"
      # redirect_to '/'
    end
  end

  def application
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete")
  end

  def hiring_calendar
    SystemValue.find_by(name: 'hiring_calendar').value
  end

  def get_date
    return Time.now
  end

  def get_next_date
    return (Time.now + 1.days)
  end
end
