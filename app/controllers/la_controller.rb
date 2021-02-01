class LaController < ApplicationController
  before_action :check_la

  def settings
    @la = LaDetail.find_by(eduPersonPrincipalName: cas_user)
  end

  def index
    @request_now = Appointment.where(datetime: nil, status: "Requested").order("created_at")
    @request_app = Appointment.where.not(datetime: !nil).where(status: "Requested", datetime: Time.now..DateTime::Infinity.new).order("datetime")

  end
end
