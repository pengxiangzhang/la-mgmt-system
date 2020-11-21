class Hiring::LastdayInterviewController < ApplicationController
  before_action :check_admin

  def create
    @application_opening = SystemValue.find_by(name: 'last_day_interview')
    @application_opening.value = params['date1']
    @application_opening.save
    redirect_to admin_hiring_url
  end
end