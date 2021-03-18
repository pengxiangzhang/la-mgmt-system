class Applicant::AcceptOfferController < ApplicationController
  def create
    application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: 'offered').first
    if application.nil?
      flash[:info] = 'You are not allow to accept this offer (offer not to find).'
      redirect_to student_application_url
    else
      application.Application_Status = 'accepted'
      application.save
      EmailMailer.new_accept(application).deliver_now
      flash[:success] = 'Successfully to accept the job offer.'
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Accept Application] User accept application ID: '#{application.id}'.")
      redirect_to student_application_url
    end
  end
end