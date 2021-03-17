class Hiring::SeePdfController < ApplicationController
  before_action :check_admin

  def create
    @applicant = Application.find_by({ id: params[:id] })
    p @applicant
    send_file("#{Rails.root}/" + @applicant.File_Location,
              filename: "LA Application - #{@applicant.NUID}.pdf",
              type: 'application/pdf',
              disposition: 'inline')
  end
end