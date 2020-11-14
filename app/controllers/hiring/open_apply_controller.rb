class Hiring::OpenApplyController < ApplicationController
  def create
    @application_opening = SystemValue.find_by(name: 'application_opening')
    @application_opening.value = params['open_for_apply']
    @application_opening.save
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
