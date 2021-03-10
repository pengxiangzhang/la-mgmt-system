class Hiring::OpenApplyController < ApplicationController
  before_action :check_admin

  def create
    @application_opening = SystemValue.find_by(name: 'application_opening')
    @application_opening.value = params['open_for_apply']
    @application_opening.save
    flash[:success] = "Successfully change the open for apply to #{params['open_for_apply']}."
    redirect_to admin_hiring_url
  end
end
