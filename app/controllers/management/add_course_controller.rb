class Management::AddCourseController < ApplicationController
  before_action :check_admin

  def create
    Course.new(course_name: params['class_id']).save
    flash[:success] = "Successfully Add " + params['class_id'] +"."
    redirect_to admin_courses_url
  end
end
