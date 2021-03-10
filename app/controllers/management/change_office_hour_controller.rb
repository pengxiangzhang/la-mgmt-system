class Management::ChangeOfficeHourController < ApplicationController
  before_action :check_admin

  def create
    @la = LaDetail.find_by({ id: params['id'] })
    if @la.nil?
      flash[:error] = 'LA not found.'
      redirect_to admin_courses_url
    elsif params['status'].empty?
      flash[:error] = 'You must select a status.'
      redirect_to admin_courses_url
    else
      @la.allowChangeHour = params['status']
      @la.save
      flash[:success] = "Successfully change to allow #{@la.user_detail.DisplayName.to_s} to change office hour to #{params['status']}"
      redirect_to admin_courses_url
    end
  end

  def update
    LaDetail.all.update_all(allowChangeHour: 'true')
    flash[:success] = 'Successfully change to allow all LA to change office hour.'
    redirect_to admin_courses_url
  end
end
