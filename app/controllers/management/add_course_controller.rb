class Management::AddCourseController < ApplicationController
  before_action :check_admin

  def create
    course = Course.find_by(course_name: params['class_id'])
    if params['class_id'].nil? || params['slack_id'].nil?
      flash[:error] = "Both input are required."
      redirect_to admin_courses_url
    elsif !course.nil?
      course.slack=params['slack_id']
      course.save
      flash[:success] = "Successfully update slack channel name for " + params['class_id'] + "."
      redirect_to admin_courses_url
    else
      Course.new(course_name: params['class_id'], slack: params['slack_id']).save
      flash[:success] = "Successfully Add " + params['class_id'] + "."
      redirect_to admin_courses_url
    end
  end
end
