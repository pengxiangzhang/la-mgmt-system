class Applicant::WithdrawController < ApplicationController

  def create
    @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
    @application.Application_Status = "withdraw"
    @application.save
    redirect_to student_application_url
  end
end
