class AdminController < ApplicationController
  around_action :cas_authentication!
  before_action :check_admin

  def management
    @users = UserDetail.where.not('updated_at <= ? AND Role=?', 6.months.ago.to_datetime, 'Student')
  end

  def hiring
    @application = Application.where.not(Application_Status: 'delete')
  end

  def courses
    @courses = Course.all.order(:course_name)
    @la = LaDetail.joins(:user_detail).all.order('user_details.eduPersonPrincipalName')
  end

  def index
    @course = Course.all.order(:course_name)
    @past = Appointment.where('created_at >= ?', 7.day.ago.to_datetime).where(status: 'Closed').order('created_at')
    @open = Appointment.where(status: 'Requested').order('created_at')
    @accepted = Appointment.where.not(status: %w[Requested Closed]).order('datetime')
  end

  def decision
    @application = Application.find_by({ id: params[:id] })
    @files = Dir.foreach('app/views/email_mailer/template').select { |x| File.file?("app/views/email_mailer/template/#{x}") }
    p @files
  end

  def queue
    @file = Dir.foreach('storage/send_later').select { |x| File.file?("storage/send_later/#{x}") }
    @file.delete('.keep')
  end

  def detail
    @request = Appointment.find_by({ id: params[:id] })
  end

  def export
    @startDate = params['start'].to_time
    @endDate = params['end'].to_time
    if @startDate > @endDate
      flash[:error] = 'Start date is larger than end date.'
      redirect_to admin_courses_url
    else
      @course = Course.all.order(:course_name)
      @result = Appointment.where(datetime: @startDate..@endDate).order('datetime')
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Export Date] Export Date from '#{@startDate}' to '#{@endDate}'.")
    end
  end

end