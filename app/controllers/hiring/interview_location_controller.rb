class Hiring::InterviewLocationController < ApplicationController
  def create
    @interview_location = SystemValue.find_by(name: 'interview_location')
    @interview_location.value = params['interview_location']
    @interview_location.save
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
