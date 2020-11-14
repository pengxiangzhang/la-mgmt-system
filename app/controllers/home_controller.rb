class HomeController < ApplicationController

  def index
    if user_type == "admin"
      redirect_to Rails.configuration.custom_prefix + '/admin/index'
    elsif user_type == "la"
      redirect_to Rails.configuration.custom_prefix + '/la/index'
    else
      redirect_to Rails.configuration.custom_prefix + '/student/index'
    end
  end
end
