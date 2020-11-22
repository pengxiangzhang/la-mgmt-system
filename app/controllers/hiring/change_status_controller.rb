class Hiring::ChangeStatusController < ApplicationController
  before_action :check_admin

  def create
    @application = Application.find_by(id: params['id'])
    @application.Application_Status = params['status']
    if params['status'] == "submitted"
      EmailMailer.thank_applying(params).deliver_now
    elsif params['status'] == "scheduling"
      EmailMailer.interview_applicant(params).deliver_now
    elsif params['status'] == "offered"
      EmailMailer.offer_applicant(params).deliver_now
    elsif params['status'] == "accepted"
      EmailMailer.accept_applicant(params).deliver_now
    elsif params['status'] == "reject"
      EmailMailer.reject_applicant(params).deliver_now
    elsif params['status'].empty?
      flash[:error] = "Error: You must select a status."
      redirect_to admin_hiring_url
    end
    @application.save
    @application.NUID
    flash[:success] = "Successfully change status for NUID:" + @application.NUID + " to " + params['status'] + "."
    redirect_to admin_hiring_url
  end
end