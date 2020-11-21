class StudentController < ApplicationController
  helper_method :hiring_calendar, :accept_application, :application_email, :application_form

  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end

  def application_form
    FormBuilder.find_by(formname: 'application')['formdata']
  end

  def application
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete")
  end

  def form
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete")
  end

  def application_email
    SystemValue.find_by(name: 'application_email').value
  end

  def hiring_calendar
    SystemValue.find_by(name: 'hiring_calendar').value
  end
end
