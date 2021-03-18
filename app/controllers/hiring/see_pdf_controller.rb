class Hiring::SeePdfController < ApplicationController
  before_action :check_admin

  def create
    @applicant = Application.find_by({ id: params[:id] })
    send_file("#{Rails.root}/" + @applicant.File_Location,
              filename: "LA Application - #{@applicant.NUID}.pdf",
              type: 'application/pdf',
              disposition: 'inline')
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|View Application] View application for ID: '#{params['id']}'.")
  end
end