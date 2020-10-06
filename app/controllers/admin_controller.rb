class AdminController < ApplicationController


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

end
