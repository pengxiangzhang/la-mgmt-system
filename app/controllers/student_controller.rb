class StudentController < ApplicationController
  helper_method :current_student

  def application
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete")
  end

  def form
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete")
  end

  def show
    @la = LaDetail.joins(:user_detail).find_by({ id: params[:id] })
  end

  def index
    @course = Course.all.order(:course_name)
    # @las = LaDetail.joins(:user_detail).where(LaCourse.select(:id).exists).uniq
    @las = LaDetail.joins(:user_detail).distinct.where("EXISTS(SELECT `id` FROM la_courses)")
    if current_student.hasAppointment
      @appointment = Appointment.where(eduPersonPrincipalName: cas_user).where.not(status: "Closed").first
    end
  end

  def current_student
    UserDetail.find_by(eduPersonPrincipalName: cas_user)
  end
end
