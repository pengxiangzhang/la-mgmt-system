class Management::RoleFormController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:error] = "Error: You must select a role for " + params['username'] + "."
      redirect_to admin_management_url
    elsif params['username'] == cas_user
      flash[:error] = "You can not change your own role."
      redirect_to admin_management_url
    else
      @user = UserDetail.find_by({ eduPersonPrincipalName: params['username'] })
      if @user.Role == "student" && params['user_type'] != "student"
        LaDetail.new({ user_detail_id: @user.id, allowChangeHour: true }).save
      elsif @user.Role != "student" && params['user_type'] == "student"
        begin
          LaDetail.joins(:user_detail).find_by({ 'user_details.eduPersonPrincipalName': params['username'] }).destroy
        rescue
          p ""
        end
      end

      @user.Role = params['user_type']
      @user.save
      flash[:success] = "Successfully changed " + params['username'] + " to " + params['user_type'] + "."
      redirect_to admin_management_url
    end
  end
end
