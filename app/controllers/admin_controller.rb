class AdminController < ApplicationController
  before_action :check_admin
  def check_admin
  if user_type!="admin"
    redirect_to '/'
  end
  end
end
