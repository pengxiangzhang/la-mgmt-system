class StudentController < ApplicationController
  before_action :check_student
  def check_student
  if user_type!="student"
    redirect_to '/'
  end
  end
end
