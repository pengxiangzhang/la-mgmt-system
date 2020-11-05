class StudentController < ApplicationController
  helper_method :get_date, :get_next_date, :hiring_calendar

  def check_student
    if user_type != "student"
      # redirect_to '/'
    end
  end

  def application
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(application_status: "withdraw").where.not(application_status: "delete")
  end

  def hiring_calendar
    SystemValue.find_by(name: 'hiring_calendar').value
  end

  def create
    if params['form_type'] == "1"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(application_status: "withdraw").first
      p "haha" + @application.inspect
      @application.application_status = "withdraw"
      @application.save
      redirect_to(student_application_url)
    end
  end

  def get_date
    return Time.now.strftime("%d/%m/%Y")
  end

  def get_next_date
    return (Time.now + 1.days).strftime("%d/%m/%Y")
  end
end
