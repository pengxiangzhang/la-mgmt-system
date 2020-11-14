class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :cas_user, :update_user, :user_type, :cas_name, :cas_email
  around_action :cas_authentication!
  protect_from_forgery with: :null_session

  def current_user
    cas_user && User.find_by(eduPersonPrincipalName: cas_user)
  end

  def cas_user
    session["cas"] && session["cas"]["user"]
  end

  def cas_name
    session["cas"]["extra_attributes"]["displayName"]
  end

  def cas_email
    session["cas"]["extra_attributes"]["email"]
  end

  def update_user
    myuser = UserDetail.find_by(eduPersonPrincipalName: cas_user)
    if cas_user && !myuser
      User.new(eduPersonPrincipalName: cas_user).save
      UserDetail.new(eduPersonPrincipalName: cas_user, DisplayName: cas_name, Email: cas_email, Role: "admin").save
    else
      myuser.update(eduPersonPrincipalName: cas_user, DisplayName: cas_name, Email: cas_email)
    end
  end

  def user_type
    return UserDetail.find_by(eduPersonPrincipalName: cas_user)["Role"]
    # Rails.logger.info "cas_auth: usertype: #{usertype.inspect}"
  end

  def cas_authentication!
    # Rails.logger.info "cas_auth: session[cas]: #{session["cas"].inspect}"
    if cas_user
      update_user
      if request
        # Rails.logger.info "cas_auth: request.fullpath: #{request.fullpath}"
      end
      yield
      # redirect_to root_url
      return
    else
      head 401
    end
  end
end