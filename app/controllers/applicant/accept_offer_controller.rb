class Applicant::AcceptOfferController < ApplicationController
  def create
    @application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: "offered").first
    @application.Application_Status = "accepted"
    @application.save
    EmailMailer.scheduled_applicant(@application).deliver_now
    redirect_to student_application_url
  end
end