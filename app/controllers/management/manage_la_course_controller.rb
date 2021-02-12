class Management::ManageLaCourseController < ApplicationController
  before_action :check_admin

  def create
    if params['user_name'].blank?
      flash[:error] = "Error: You must enter a username."
      redirect_to admin_courses_url
    else
      @la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': params['user_name'])
      if @la.nil?
        flash[:error] = "Error: User not find for this username: " + params['user_name'] + ". Make sure they have an LA role."
        redirect_to admin_courses_url
      else
        @la.course = params['course-select']
        @la.save
        flash[:success] = "Successfully changed " + @la.user_detail.eduPersonPrincipalName + " to support these course: " + params['course-select'].to_s.tr('[""]', '') + "."
        #TODO Change @la.user_detail.eduPersonPrincipalName to @la.user_detail.DisplayName
        redirect_to admin_courses_url
      end
    end
  end
end