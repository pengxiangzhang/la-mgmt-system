class Management::RoleFormController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:error] = "Error: You must select a role for " + params['username'] + "."
      redirect_to admin_management_url
    else
      p params['username']
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      @user.Role = params['user_type']
      @user.save
      flash[:success] = "Successfully change " + params['username'] + " to " + params['user_type']
      redirect_to admin_management_url
    end
  end
end
