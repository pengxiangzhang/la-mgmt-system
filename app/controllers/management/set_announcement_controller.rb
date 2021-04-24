class Management::SetAnnouncementController < ApplicationController
  before_action :check_admin

  def create
    case params['user']
    when '1'
      @action = global_announcement
      @action.color_1 = params['color1']
      @action.color_2 = params['color2']
      @action.color_3 = params['color3']
      @action.text = params['text']
      @action.save
      flash[:success] = 'Successfully change the announcement for student.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for student to '#{params['text']}'.")
    when '2'
      @action = la_announcement
      @action.color_1 = params['color1']
      @action.color_2 = params['color2']
      @action.color_3 = params['color3']
      @action.text = params['text']
      @action.save
      flash[:success] = 'Successfully change the announcement for la.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for la to '#{params['text']}'.")
    when '3'
      @action = admin_announcement
      @action.color_1 = params['color1']
      @action.color_2 = params['color2']
      @action.color_3 = params['color3']
      @action.text = params['text']
      @action.save
      flash[:success] = 'Successfully change the announcement for admin.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Set Announcement] Change announcement for admin to '#{params['text']}'.")
    end
    redirect_to admin_management_url
  end
end
