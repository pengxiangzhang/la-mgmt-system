class Management::ManageLaCourseController < ApplicationController
  before_action :check_admin

  def create
    if params['user_name'].blank?
      flash[:error] = "Error: You must enter a username."
      redirect_to admin_courses_url
    elsif params['course-select'].blank?
      flash[:error] = "Error: You must select a course for " + params['user_name'] + "."
      redirect_to admin_courses_url
      else
    @la = LaDetail.find_by(eduPersonPrincipalName: params['user_name'])
    if @la.nil?
      flash[:error] = "Error: User not find for this username: " + params['user_name'] + ". Make sure they have an LA role."
      redirect_to admin_courses_url
    else
      @la.course = params['course-select']
      @la.save
      flash[:success] = "Successfully changed " + @la.name + " to support these course: " + params['course-select'].to_s.tr('[""]', '') + "."
      redirect_to admin_courses_url
    end
    end
  end
end