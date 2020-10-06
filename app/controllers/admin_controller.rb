class AdminController < ApplicationController
<<<<<<< HEAD


  def index
    @users= UserDetail.all
  end

  def show
    @user= UserDetail.find(params[:id])
  end

   def change
     user= UserDetail.first(:conditions => ["eduPersonPrincipalName = ?", [params: eduPersonPrincipalName ]])
     user.role("LA")
     user.save
   end

=======
  before_action :check_admin
  def check_admin
  if user_type!="admin"
    redirect_to '/'
  end
  end
>>>>>>> nav_bar
end
