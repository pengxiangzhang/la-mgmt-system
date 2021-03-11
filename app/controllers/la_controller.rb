class LaController < ApplicationController
  before_action :check_la
  helper_method :get_la_course

  def settings
    @la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
  end

  def index
    @la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
    @dateOfWeek = Date.today.strftime('%A')
    laCass = Array.new
    get_la_course(@la.id).each do |course|
      laCass.push(course.course.course_name)
    end
    @request_now = Appointment.where(class_id: laCass, datetime: nil, status: 'Requested').order('created_at')
    @request_app = Appointment.where(datetime: !nil, class_id: laCass, class_id: laCass, status: 'Requested', datetime: Time.now..DateTime::Infinity.new).order('datetime')
    @accept = Appointment.where(la_eduPersonPrincipalName: cas_user).where.not(status: 'Closed').order('datetime')
    @past = Appointment.where('created_at >= ?', 7.day.ago.to_datetime).where(la_eduPersonPrincipalName: cas_user, status: 'Closed').order('created_at')
  end

  def get_la_course(id)
    @lac = LaCourse.joins(:course).where(la_detail_id: id)
  end

  def show_request
    @request = Appointment.find_by({ id: params[:id] })
  end

  def show_finish
    @request = Appointment.find_by({ id: params[:id] })
  end
end