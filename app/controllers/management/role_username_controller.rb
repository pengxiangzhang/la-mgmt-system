class Management::RoleUsernameController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:error] = "Error: You must select a role for " + params['username'] + "."
      redirect_to admin_management_url
    else
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user == nil
        flash[:error] = "User " + params['username'] + " not found."
        redirect_to admin_management_url
      else
        @user.Role = params['user_type']
        @user.save
        flash[:success] = "Successfully changed " + params['username'] + " to " + params['user_type'] + "."
        redirect_to admin_management_url
      end
    end
  end
end
