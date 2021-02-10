class StudentController < ApplicationController
  helper_method :hiring_calendar, :accept_application, :application_email, :application_form, :current_student

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

  def show
    @la = LaDetail.find_by(id: params[:id])
  end

  def current_student
    UserDetail.find_by(eduPersonPrincipalName: cas_user)
  end

  def index
    @course = Course.all.order(:course_name)
    @las = LaDetail.where.not(course: nil)
    if current_student.hasAppointment
      @appointment = Appointment.where(eduPersonPrincipalName: cas_user).where.not(status: "Closed").first
    end
  end

end
