class Hiring::DeleteAllController < ApplicationController
  before_action :check_admin

  def create
    Application.where.not(Application_Status: 'delete').update_all(Application_Status: 'delete')
    flash[:success] = 'Successfully delete all applications.'
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Delete Application] Delete all application.")
    redirect_to admin_hiring_url
  end
end
