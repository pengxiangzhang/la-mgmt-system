class HomeController < ApplicationController
  def index
    case user_type
    when 'admin'
      redirect_to admin_index_url
    when 'la'
      redirect_to la_index_url
    else
      redirect_to student_index_url
    end
  end
end
