class HomeController < ApplicationController

  def index
    if user_type=="admin"
      redirect_to '/admin/index'
    elsif user_type == "la"
      redirect_to '/la/index'
    else
      redirect_to '/student/index'
    end
  end
end
