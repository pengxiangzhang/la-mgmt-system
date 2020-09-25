class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :cas_user

  before_action :cas_authentication!

  def current_user
    cas_user && User.find_by(email: cas_user)
  end

  private

  def cas_authentication!
    render status: 401 unless cas_user
  end

  def cas_user
    session["cas"] && session["cas"]["user"]
  end
end