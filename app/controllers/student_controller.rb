class StudentController < ApplicationController
  around_action :cas_authentication!
  helper_method :current_student

  def application
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: 'withdraw').where.not(Application_Status: 'delete')
  end

  def form
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: 'withdraw').where.not(Application_Status: 'delete')
  end

  def show
    @la = LaDetail.joins(:user_detail).find_by({ id: params[:id] })
  end

  def index
    @course = Course.all.order(:course_name)
    @las = LaDetail.joins(:la_courses).joins(:user_detail).distinct
    if current_student.hasAppointment
      @appointment = Appointment.where(eduPersonPrincipalName: cas_user).where.not(status: 'Closed').first
    end
  end

  def current_student
    UserDetail.find_by(eduPersonPrincipalName: cas_user)
  end

  def contact
    render 'home/contact'
  end
end
