class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :cas_user

  #before_action :cas_authentication!
  around_action :cas_authentication!

  def current_user
    cas_user && User.find_by(eduPersonPrincipalName: cas_user)
  end

  private

  def cas_authentication!
	  Rails.logger.info "cas_auth: session[cas]: #{session["cas"].inspect}"
	  Rails.logger.info "cas_auth: session.keys: #{session.keys}"
    if cas_user
	    if request
		    Rails.logger.info "cas_auth: request.fullpath: #{request.fullpath}"
    	    end
      yield
      # redirect_to root_url
      return
    else
      render status: 401
    end

  end

  def cas_user
    session["cas"] && session["cas"]["eduPersonPrincipalName"]
    # session["cas"] && session["cas"]["user"]
  end
end
