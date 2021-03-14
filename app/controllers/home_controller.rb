class HomeController < ApplicationController
  def index
    if browser.bot?
      render layout: false
    else
      redirect_to login_index_url
    end
  end

  def contact
    render layout: false
  end
end
