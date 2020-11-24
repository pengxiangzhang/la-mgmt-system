class Hiring::ApplicationNoteController < ApplicationController
  before_action :check_admin

  def create
    @application = Application.where(NUID: params["NUID"]).where.not(Application_Status: "delete").where.not(Application_Status: "withdraw").first
    if @application.blank?
      flash[:notice] = "Application Not Found for NUID: " + params["NUID"]
    else
      if params["date"] != "" and params["time"] != ""
        time = params[:date] + " " + params[:time] + ":00"
        @application.Application_Status = "scheduled"
        @application.Interview_Time = time

      end
      if params["score"] != ""
        @application.Score = params["score"]
      end
      if params["application_form"]
        file_name = @application.File_Location
        File.open(Rails.root.join(file_name), 'wb') do |file|
          file.write(params[:application_form].read)
        end
      end
      @application.save
    end
    redirect_to admin_hiring_url
  end
end
