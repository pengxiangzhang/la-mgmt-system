class LaController < ApplicationController
  before_action :check_la

  def check_la
    if user_type != "la"
      redirect_to '/'
    end
  end

end
