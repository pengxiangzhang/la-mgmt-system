class AdminController < ApplicationController
  before_action :check_admin

  def check_admin
    if user_type != "admin"
      redirect_to '/'
    end
  end

  def management
    @users = UserDetail.all
    flash.alert = ""
  end

  def show
    @user = UserDetail.find(params[:id])
  end

  def edit
    @users = UserDetail.all
    @user = UserDetail.find(params[:id])
    p params
    @user.role = "admin"
    @user.save
  end

  def create
    @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
    if @user == nil
      redirect_to "/admin/management", notice: "user not found"
    else
      @user.role = params['user_type']
      @user.save
      redirect_to "/admin/management", notice: "Successfully change " + params['username'] + " to " + params['user_type']
    end
  end
end