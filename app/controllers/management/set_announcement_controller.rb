class Management::SetAnnouncementController < ApplicationController
  before_action :check_admin

  def create
    if params['user'] == "1"
      SystemValue.find_by(name: 'global_color_1').update({ value: params["color1"] })
      SystemValue.find_by(name: 'global_color_2').update({ value: params["color2"] })
      SystemValue.find_by(name: 'global_text').update({ value: params["text"] })
      flash[:success] = "Successfully change the announcement for student."
    elsif params['user'] == "2"
      SystemValue.find_by(name: 'la_color_1').update({ value: params["color1"] })
      SystemValue.find_by(name: 'la_color_2').update({ value: params["color2"] })
      SystemValue.find_by(name: 'la_text').update({ value: params["text"] })
      flash[:success] = "Successfully change the announcement for la."
    elsif params['user'] == "3"
      SystemValue.find_by(name: 'admin_color_1').update({ value: params["color1"] })
      SystemValue.find_by(name: 'admin_color_2').update({ value: params["color2"] })
      SystemValue.find_by(name: 'admin_text').update({ value: params["text"] })
      flash[:success] = "Successfully change the announcement for admin."
    end
    redirect_to admin_management_url
  end
end
