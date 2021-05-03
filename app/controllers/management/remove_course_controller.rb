class Management::RemoveCourseController < ApplicationController
  before_action :check_admin

  def destroy
    @class = Course.find_by({ course_name: params['class_id'] })
    if @class.nil?
      flash[:info] = 'Class not found.'
    else
      @class.destroy
      flash[:success] = "Successfully remove #{params['class_id']}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Remove Course] Remove course '#{params['class_id']}'.")
    end
    redirect_to admin_courses_url
  end
end
