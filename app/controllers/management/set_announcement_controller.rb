class Management::SetAnnouncementController < ApplicationController
  before_action :check_admin

  def create
    case params['user']
    when '1'
      SystemValue.find_by(name: 'global_color_1').update({ value: params['color1'] })
      SystemValue.find_by(name: 'global_color_2').update({ value: params['color2'] })
      SystemValue.find_by(name: 'global_text').update({ value: params['text'] })
      flash[:success] = 'Successfully change the announcement for student.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for student to '#{params['text']}'.")
    when '2'
      SystemValue.find_by(name: 'la_color_1').update({ value: params['color1'] })
      SystemValue.find_by(name: 'la_color_2').update({ value: params['color2'] })
      SystemValue.find_by(name: 'la_text').update({ value: params['text'] })
      flash[:success] = 'Successfully change the announcement for la.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for la to '#{params['text']}'.")
    when '3'
      SystemValue.find_by(name: 'admin_color_1').update({ value: params['color1'] })
      SystemValue.find_by(name: 'admin_color_2').update({ value: params['color2'] })
      SystemValue.find_by(name: 'admin_text').update({ value: params['text'] })
      flash[:success] = 'Successfully change the announcement for admin.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for admin to '#{params['text']}'.")
    end
    redirect_to admin_management_url
  end
end
