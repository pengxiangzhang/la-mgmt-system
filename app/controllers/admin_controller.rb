class AdminController < ApplicationController
  before_action :check_admin
  helper_method :application_form, :hiring_email, :system_url, :hiring_calendar

  def check_admin
    if user_type != "admin"
      render(:file => File.join(Rails.root, 'public/403.html'), :status => 403, :layout => false)
    end
  end

  def management
    @users = UserDetail.all
    flash.alert = ""
  end

  def hiring
    @application = Application.where.not(application_status: "delete")
  end

  def show
    @user = UserDetail.find(params[:id])
  end

  def hiring_email
    SystemValue.find_by(name: 'application_email')
  end

  def system_url
    SystemValue.find_by(name: 'system_url')
  end

  def hiring_calendar
    SystemValue.find_by(name: 'hiring_calendar')
  end

  def edit
    p params[:user_id]
    @users = UserDetail.all
    @user = UserDetail.find(params[:id])
    @user.role = "admin"
    @user.save
  end

  def create
    if params['form_type'] == "1"
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user == nil
        flash[:notice] = "user not found"
        redirect_to "/admin/management", notice: "user not found"
      else
        @user.role = params['user_type']
        @user.save
        flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
        redirect_to "/admin/management"
      end
    elsif params['form_type'] == "2"
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      @user.role = params['user_type']
      @user.save
      flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
      redirect_to "/admin/management"
    elsif params['form_type'] == "3"
      @email = SystemValue.find_by(name: 'application_email')
      @email.value = params['hiring_email']
      @email.save
      redirect_to "/admin/management"
    elsif params['form_type'] == "4"
      @url = SystemValue.find_by(name: 'system_url')
      @url.value = params['system_url']
      @url.save
      redirect_to "/admin/management"
    elsif params['form_type'] == "5"
      send_file("#{Rails.root}/" + params[:location],
                :filename => "LA Application - " + params[:filename] + ".pdf",
                :type => "application/pdf", #for example if pdf
                :disposition => 'inline')
    elsif params['form_type'] == "6"
      @application = Application.find_by(id: params['id'])
      @application.application_status = params['status']
      @application.save
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
      end
      redirect_to "/admin/hiring"
    elsif params['form_type'] == "7"
      @url = SystemValue.find_by(name: 'hiring_calendar')
      @url.value = params['hiring_calendar']
      @url.save
      redirect_to "/admin/management"
    elsif params['form_type'] == "8"
      @application = Application.where.not(application_status: "delete")
      @application.application_status = "delete"
      @application.save
      redirect_to "/admin/management"
    end
  end

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end
end