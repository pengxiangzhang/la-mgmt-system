class Officehour::SetLocationController < ApplicationController
  before_action :check_la

  def create
    la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
    la.location = params["location"]
    la.save
    flash[:success] = "You have successfully change the meeting location."
    redirect_to la_settings_url
  end
end