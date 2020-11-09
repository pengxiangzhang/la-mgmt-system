class ApplicantProcessController < ApplicationController

  def create
    if params['form_type'] == "1"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
      @application.Application_Status = "withdraw"
      @application.save
      redirect_to(student_application_url)
    elsif params['form_type'] == "2"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
      @time = params[:date]+" "+params[:time]+":00"
      @application.Application_Status = "scheduled"
      @application.Interview_Time=time
      @application.save
      EmailMailer.scheduled_applicant(@application).deliver_now
      EmailMailer.scheduled_application(@application).deliver_now
      redirect_to(student_application_url)
    end
  end

end
