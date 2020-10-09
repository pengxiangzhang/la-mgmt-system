class StudentController < ApplicationController
  before_action :check_student
  helper_method :get_date, :get_next_date
  def check_student
  if user_type!="student"
    # redirect_to '/'
  end
  end
  def get_date
    return Time.now.strftime("%d/%m/%Y")
  end
  def get_next_date
    return (Time.now + 1.days).strftime("%d/%m/%Y")
  end
end
