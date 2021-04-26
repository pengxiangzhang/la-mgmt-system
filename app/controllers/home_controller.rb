class HomeController < ApplicationController
  def index
    if browser.bot?
      render
    else
      redirect_to login_index_url
    end
  end
end
