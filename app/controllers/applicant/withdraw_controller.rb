class Applicant::WithdrawController < ApplicationController
  def create
    application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: 'withdraw').where.not(Application_Status: 'delete').first
    if application.nil?
      flash[:info] = 'You have no application to withdraw.'
      redirect_to student_application_url
    else
      application.Application_Status = 'withdraw'
      application.save
      flash[:success] = 'Successfully withdraw the application.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Withdraw Application] User withdraw application ID: '#{application.id}'.")
      redirect_to student_application_url
    end
  end
end
