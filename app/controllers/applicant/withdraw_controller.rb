class Applicant::WithdrawController < ApplicationController
  def create
    application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: 'withdraw').where.not(Application_Status: 'delete').first
    if application.nil?
      flash[:error] = 'You have no application to withdraw.'
      redirect_to student_application_url
    else
      application.Application_Status = 'withdraw'
      application.save
      flash[:success] = 'Successfully withdraw the application.'
      redirect_to student_application_url
    end
  end
end
