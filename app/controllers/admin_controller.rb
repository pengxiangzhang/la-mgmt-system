class AdminController < ApplicationController
  before_action :check_admin

  def management
    @users = UserDetail.where.not("updated_at <= ? AND Role=?", 6.months.ago.to_datetime, "Student")
  end

  def hiring
    @application = Application.where.not(Application_Status: "delete")
  end

  def courses
    @courses = Course.all.order(:course_name)
    @la = LaDetail.joins(:user_detail).all.order("user_details.eduPersonPrincipalName")
  end

  def index
    @course = Course.all.order(:course_name)
    @past = Appointment.where('created_at >= ?', 7.day.ago.to_datetime).where(status: "Closed").order("created_at")
    @open = Appointment.where(status: "Requested").order("created_at")
    @accepted = Appointment.where.not(status: ["Requested", "CLosed"]).order("datetime")
  end

  def decision
    @application = Application.find_by({ id: params[:id] })
    @files = Dir.foreach("app/views/email_mailer/template").select { |x| File.file?("#{"app/views/email_mailer/template"}/#{x}") }
    p @files
  end

  def queue
    @file = Dir.foreach("storage/send_later").select { |x| File.file?("#{"storage/send_later"}/#{x}") }
    @file.delete(".keep")
  end
end