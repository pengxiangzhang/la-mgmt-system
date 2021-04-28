class Management::ChangeOfficeHourController < ApplicationController
  before_action :check_admin

  def create
    @la = LaDetail.find_by({ id: params['id'] })
    if @la.nil?
      flash[:info] = 'LA not found.'
    elsif params['status'].empty?
      flash[:info] = 'You must select a status.'
    else
      @la.allowChangeHour = params['status']
      @la.save
      flash[:success] = "Successfully change to allow #{@la.user_detail.DisplayName.to_s} to change office hour to #{params['status']}"
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Allow Change Office Hour] Change to allow '#{@la.user_detail.eduPersonPrincipalName.to_s}' to change office hour to '#{params['status']}'.")
    end
    redirect_to admin_courses_url
  end

  def update
    LaDetail.all.update_all(allowChangeHour: 'true')
    flash[:success] = 'Successfully change to allow all LA to change office hour.'
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Allow Change Office Hour] Change to allow all LA change office hour.")
    redirect_to admin_courses_url
  end
end
