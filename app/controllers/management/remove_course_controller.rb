class Management::RemoveCourseController < ApplicationController
  before_action :check_admin

  def destroy
    @class=Course.find_by(course_name: params['class_id'])
    @class.delete
    flash[:success] = "Successfully remove " + params['class_id'] +"."
    redirect_to admin_courses_url
  end
end
