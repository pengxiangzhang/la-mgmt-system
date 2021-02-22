class Hiring::SeePdfController < ApplicationController
  before_action :check_admin

  def create
    @applicant = Application.where({ :NUID => params[:nuid] }).where({ :Application_Status => params[:status] }).first
    send_file("#{Rails.root}/" + @applicant.File_Location,
              :filename => "LA Application - " + @applicant.NUID + ".pdf",
              :type => "application/pdf", #for example if pdf
              :disposition => 'inline')
  end
end