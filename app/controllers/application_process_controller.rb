class ApplicationProcessController < ApplicationController

  def create
    if params['form_type'] == "1"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(application_status: "withdraw").where.not(application_status: "deleted").first
      @application.application_status = "withdraw"
      @application.save
      redirect_to(student_application_url)
    elsif params['form_type'] == "2"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(application_status: "withdraw").where.not(application_status: "deleted").first
      time = params[:date]+" "+params[:time]+":00"
      @application.application_status = "scheduled"
      @application.interview_time=time
      @application.save
      redirect_to(student_application_url)
    end
  end

end
