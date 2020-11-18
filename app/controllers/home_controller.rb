class HomeController < ApplicationController

  def index
    if user_type == "admin"
      redirect_to admin_index_url
    elsif user_type == "la"
      redirect_to la_index_url
    else
      redirect_to student_index_url
    end
  end
end
