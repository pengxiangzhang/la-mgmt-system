class AdminController < ApplicationController
  before_action :check_admin

  def management
    @users = UserDetail.all
  end

  def hiring
    @application = Application.where.not(Application_Status: "delete")
  end

  def courses
    @courses = Course.all.order(:course_name)
    @la = LaDetail.joins(:user_detail).all.order("user_details.eduPersonPrincipalName")
  end

end