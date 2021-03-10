class ApplicationController < ActionController::Base
  require 'net/http'
  require 'uri'
  require 'json'
  require 'browser'

  helper_method :current_user, :cas_user, :update_user, :user_type, :cas_name, :cas_email
  around_action :cas_authentication!
  add_flash_types :success, :error, :info

  def cas_user
    session['cas'] && session['cas']['user']
  end

  def cas_name
    session['cas']['extra_attributes']['displayName']
  end

  def cas_email
    session['cas']['extra_attributes']['email']
  end

  def update_user
    my_user = UserDetail.find_by(eduPersonPrincipalName: cas_user)
    if cas_user && !my_user
      UserDetail.new(eduPersonPrincipalName: cas_user, DisplayName: cas_name, Email: cas_email, Role: 'student').save
    else
      my_user.update(eduPersonPrincipalName: cas_user, DisplayName: cas_name, Email: cas_email, updated_at: Time.now)
    end

  end

  def user_type
    UserDetail.find_by(eduPersonPrincipalName: cas_user)['Role']
  end

  def cas_authentication!
    if cas_user
      update_user
      if request
      end
      yield
      nil
    else
      head 401
    end
  end

  def check_admin
    render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false) if user_type != 'admin'
  end

  def check_la
    render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false) if user_type == 'student'
  end

  def send_slack(channel, message)
    notifier = Slack::Notifier.new SLACK_WEBHOOK_URL do
      defaults channel: "##{channel}",
               username: 'LAProMT Notification'
    end
    notifier.ping message
  end
end