class ApplicationController < ActionController::Base
  require 'net/http'
  require 'uri'
  require 'json'
  require 'browser'

  helper_method :current_user, :cas_user, :update_user, :user_type, :cas_name, :cas_email, :global_announcement,
                :la_announcement, :admin_announcement
  add_flash_types :success, :info, :error

  def cas_user
    session['cas'] && session['cas']['user']
  end

  def cas_name
    session['cas']['extra_attributes']['displayName']
  end

  def cas_email
    session['cas']['extra_attributes']['email']
  end

  def global_announcement
    Announcement.find_by(name: 'admin')
  end

  def la_announcement
    Announcement.find_by(name: 'la')
  end

  def admin_announcement
    Announcement.find_by(name: 'student')
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
    if user_type != 'admin'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Block Access Admin] User trying to access '#{request.path}'.")
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  def check_la
    if %w[student block].include? user_type
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Block Access LA] User trying to access '#{request.path}'.")
      render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false)
    end
  end

  def check_block
    if user_type == 'block'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Block Access List] User trying to access '#{request.path}'.")
      render(file: File.join(Rails.root, 'public/422.html'), status: 422, layout: false)
    end
  end

  def check_file(data)
    if data[:file].present?
      (data[:file] || []).each do |muti|
        if muti.size > 5_242_880
          return true
        end
      end
    end
    false
  end

  def is_human(captcha_response)
    uri = URI.parse("https://hcaptcha.com/siteverify?secret=#{HCAPTCAHA_SECRTY_KEY}&response=#{captcha_response}")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json['success']
  end

  def send_slack(channel, message)
    notifier = Slack::Notifier.new SLACK_WEBHOOK_URL do
      defaults channel: "##{channel}",
               username: 'LAProMT Notification'
    end
    notifier.ping message
  end

  def send_interaction(student, la, course, interactionType, recommend)
    student_id = find_user_key(student)
    if student_id.nil?
      false
    else
      uri = URI.parse("#{SystemValue.find_by(name: 'survey_url').value}/sendEmail.php")
      request = Net::HTTP::Post.new(uri)
      request.body = JSON.dump({
                                 'studentID' => student_id,
                                 'laCSE' => la,
                                 'course' => course,
                                 'interactionType' => interactionType,
                                 'recommended' => recommend
                               })

      req_options = {
        use_ssl: uri.scheme == 'https'
      }

      Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      true
    end
  end

  def find_user_key(username)
    uri = URI.parse("#{SystemValue.find_by(name: "survey_url").value}/findStudent.php")
    request = Net::HTTP::Post.new(uri)
    request.body = JSON.dump({
                               'canvas_username' => username
                             })

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    data = response.body
    data.delete! '[]'
    JSON.parse(data)['username_key']
  end
end