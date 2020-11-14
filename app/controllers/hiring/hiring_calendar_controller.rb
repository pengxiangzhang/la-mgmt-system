class Hiring::HiringCalendarController < ApplicationController
  before_action :check_admin

  def create
    @url = SystemValue.find_by(name: 'hiring_calendar')
    @url.value = params['hiring_calendar']
    @url.save
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
