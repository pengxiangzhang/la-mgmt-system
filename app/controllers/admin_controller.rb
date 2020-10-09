class AdminController < ApplicationController
  before_action :check_admin
  def check_admin
  if user_type!="admin"
    redirect_to '/'
  end
  end

  def showall
    @users= UserDetail.all
  end

  def show
    @user= UserDetail.find(params[:id])
  end

   def edit
     @users= UserDetail.all
     @user= UserDetail.find(params[:id])
     @user.role = "la"
     @user.save
   end

end
