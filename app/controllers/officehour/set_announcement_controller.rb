class Officehour::SetAnnouncementController < ApplicationController
  before_action :check_la

  def create
    la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
    la.announcement = params['announcement']
    la.save
    flash[:success] = 'You have successfully change your announcement.'
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change their announcement to '#{params['announcement']}'.")
    redirect_to la_settings_url
  end
end