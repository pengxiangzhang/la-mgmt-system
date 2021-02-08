class LaController < ApplicationController
  before_action :check_la

  def settings
    @la = LaDetail.find_by(eduPersonPrincipalName: cas_user)
  end

  def index
    @la = LaDetail.find_by(eduPersonPrincipalName: cas_user)
    @dateOfWeek = Date.today.strftime('%A')
    laCass = @la.course.gsub(/(\[\"|\"\])/, '').split('", "')
    @request_now = Appointment.where(class_id: laCass, datetime: nil, status: "Requested").order("created_at")
    @request_app = Appointment.where(datetime: !nil, class_id: laCass, class_id: laCass, status: "Requested", datetime: Time.now..DateTime::Infinity.new).order("datetime")
    @accept = Appointment.where(la_eduPersonPrincipalName:cas_user).where.not(status: "Closed").order("datetime")
  end
end
