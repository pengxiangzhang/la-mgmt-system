class Management::RoleUsernameController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:notice] = "Error: You must select a role."
      redirect_to Rails.configuration.custom_prefix + "/admin/management"
    else
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user == nil
        flash[:notice] = "user not found"
        redirect_to Rails.configuration.custom_prefix + "/admin/management", notice: "user not found"
      else
        @user.Role = params['user_type']
        @user.save
        flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
        redirect_to Rails.configuration.custom_prefix + "/admin/management"
      end
    end
  end
end
