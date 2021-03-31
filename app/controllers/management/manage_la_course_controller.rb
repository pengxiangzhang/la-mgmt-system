class Management::ManageLaCourseController < ApplicationController
  before_action :check_admin

  def create
    if params['user_name'].blank?
      flash[:info] = 'Error: You must enter a username.'
      redirect_to admin_courses_url
    else
      @la = LaDetail.joins(:user_detail).find_by({ 'user_details.eduPersonPrincipalName': params['user_name'] })
      if @la.nil?
        flash[:info] = "Error: User not find for this username: #{params['user_name']}. Make sure they have an LA role."
        redirect_to admin_courses_url
      else
        LaCourse.where(la_detail_id: @la.id).delete_all
        course = params['course-select'].to_a

        course.each do |course|
          LaCourse.new(la_detail_id: @la.id, course_id: course).save
        end
        flash[:success] = "Successfully changed course support for #{@la.user_detail.DisplayName}."
        ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Manage LA Course] Change course support for '#{@la.user_detail.eduPersonPrincipalName}' to '#{params['course-select']}'.")
        redirect_to admin_courses_url
      end
    end
  end
end