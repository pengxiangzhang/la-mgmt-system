class Officehour::SetAnnouncementController < ApplicationController
  before_action :check_la

  def create
    la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
    la.announcement = params['announcement']
    la.save
    flash[:success] = 'You have successfully change your announcement.'
    redirect_to la_settings_url
  end
end