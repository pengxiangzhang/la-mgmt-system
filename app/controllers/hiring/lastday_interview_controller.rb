class Hiring::LastdayInterviewController < ApplicationController
def create
  @application_opening = SystemValue.find_by(name: 'last_day_interview')
  @application_opening.value = params['date1']
  @application_opening.save
  redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
end
end