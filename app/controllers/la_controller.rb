class LaController < ApplicationController
  before_action :check_la

  def check_la
    if user_type != "la"
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
  end

end
