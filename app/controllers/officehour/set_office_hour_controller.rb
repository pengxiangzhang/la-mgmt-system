class Officehour::SetOfficeHourController < ApplicationController
  before_action :check_la

  def create

    la = LaDetail.find_by(eduPersonPrincipalName: cas_user)
    if la.allowChangeHour
      if !params["monday"].blank?
        la.Monday = params["monday"]
      end
      if !params["tuesday"].blank?
        la.Tuesday = params["tuesday"]
      end
      if !params["wednesday"].blank?
        la.Wednesday = params["wednesday"]
      end
      if !params["thursday"].blank?
        la.Thursday = params["thursday"]
      end
      if !params["friday"].blank?
        la.Friday = params["friday"]
      end
      if !params["saturday"].blank?
        la.Saturday = params["saturday"]
      end
      if !params["sunday"].blank?
        la.Sunday = params["sunday"]
      end
      la.allowChangeHour = false
      la.save
      flash[:success] = "You have successfully change your office hour."
      redirect_to la_settings_url
    else
      flash[:error] = "You are not allowed to change your office hour."
      redirect_to la_settings_url
    end
  end
end