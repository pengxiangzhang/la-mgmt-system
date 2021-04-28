class Management::RoleFormController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:info] = "Error: You must select a role for #{params['username']}."
    elsif params['username'] == cas_user
      flash[:error] = 'You can not change your own role.'
    else
      @user = UserDetail.find_by({ eduPersonPrincipalName: params['username'] })
      if ((@user.Role == 'student') || (@user.Role == 'block')) && ((params['user_type'] != 'student') || (params['user_type'] != 'block'))
        LaDetail.new({ user_detail_id: @user.id, allowChangeHour: true }).save
      elsif ((@user.Role != 'student') || (@user.Role != 'block')) && ((params['user_type'] == 'student') || (params['user_type'] == 'block'))
        begin
          LaDetail.joins(:user_detail).find_by({ 'user_details.eduPersonPrincipalName': params['username'] }).destroy
        rescue
          ; # Ignored
        end
      end

      @user.Role = params['user_type']
      @user.save
      flash[:success] = "Successfully changed #{params['username']} to #{params['user_type']}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Role Form] Change role for '#{params['username']}' to '#{params['user_type']}'.")
    end
    redirect_to admin_management_url
  end
end