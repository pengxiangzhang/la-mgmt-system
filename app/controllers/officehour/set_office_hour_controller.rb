class Officehour::SetOfficeHourController < ApplicationController
  before_action :check_la

  def create
    la = LaDetail.joins(:user_detail).find_by('user_details.eduPersonPrincipalName': cas_user)
    if la.allowChangeHour
      la.Monday = params['monday'] unless params['monday'].blank?
      la.Tuesday = params['tuesday'] unless params['tuesday'].blank?
      la.Wednesday = params['wednesday'] unless params['wednesday'].blank?
      la.Thursday = params['thursday'] unless params['thursday'].blank?
      la.Friday = params['friday'] unless params['friday'].blank?
      la.Saturday = params['saturday'] unless params['saturday'].blank?
      la.Sunday = params['sunday'] unless params['sunday'].blank?
      la.allowChangeHour = false
      la.save
      flash[:success] = 'You have successfully change your office hour.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set office hour] Change their office hour.")
      redirect_to la_settings_url
    else
      flash[:info] = 'You are not allowed to change your office hour.'
      redirect_to la_settings_url
    end
  end
end