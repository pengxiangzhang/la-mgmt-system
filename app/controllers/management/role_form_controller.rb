class Management::RoleFormController < ApplicationController
  before_action :check_admin

  def create
    if params['user_type'].blank?
      flash[:error] = "Error: You must select a role for " + params['username'] + "."
      redirect_to admin_management_url
    else
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user.Role != "la" && params['user_type'] == "la"
        LaDetail.new(eduPersonPrincipalName: params['username'], name: @user.DisplayName, allowChangeHour: true).save
      elsif @user.Role == "la" && params['user_type'] != "la"
        LaDetail.find_by(eduPersonPrincipalName: params['username']).delete
      end

      @user.Role = params['user_type']
      @user.save
      flash[:success] = "Successfully changed " + params['username'] + " to " + params['user_type'] + "."
      redirect_to admin_management_url
    end
  end
end
