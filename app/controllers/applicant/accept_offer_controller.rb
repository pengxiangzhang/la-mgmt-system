class Applicant::AcceptOfferController < ApplicationController
  def create
    application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: "offered").first
    if application.nil?
      flash[:error] = "You are not allow to accept this offer (offer not to find)."
      redirect_to student_application_url
    else
      application.Application_Status = "accepted"
      application.save
      EmailMailer.scheduled_applicant(application).deliver_now
      flash[:success] = "Successfully to accept the job offer."
      redirect_to student_application_url
    end
  end
end