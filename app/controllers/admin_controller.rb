class AdminController < ApplicationController
  before_action :check_admin

  def check_admin
    if user_type != "admin"
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
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
    p params[:user_id]
    @users = UserDetail.all
    @user = UserDetail.find(params[:id])
    @user.role = "admin"
    @user.save
  end

  def create
    if params['form_type'] == "1"
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user == nil
        flash[:notice] = "user not found"
        redirect_to "/admin/management", notice: "user not found"
      else
        @user.role = params['user_type']
        @user.save
        flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
        redirect_to "/admin/management"
      end
    elsif params['form_type'] == "2"
      p params
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      @user.role = params['user_type']
      @user.save
      flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
      redirect_to "/admin/management"
    end
  end
end