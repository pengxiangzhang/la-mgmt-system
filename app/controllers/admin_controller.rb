class AdminController < ApplicationController
  before_action :check_admin
  helper_method :application_form, :hiring_email, :system_url, :hiring_calendar, :accept_application

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
    @application = Application.where.not(Application_Status: "delete")
  end

  def show
    @user = UserDetail.find(params[:id])
  end

  def accept_application
    SystemValue.find_by(name: 'application_opening')
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
    @user.Role = "admin"
    @user.save
  end

  def create
    if params['form_type'] == "1"
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      if @user == nil
        flash[:notice] = "user not found"
        redirect_to "/admin/management", notice: "user not found"
      else
        @user.Role = params['user_type']
        @user.save
        flash[:notice] = "Successfully change " + params['username'] + " to " + params['user_type']
        redirect_to "/admin/management"
      end
    elsif params['form_type'] == "2"
      @user = UserDetail.find_by(eduPersonPrincipalName: params['username'])
      @user.Role = params['user_type']
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
      @application.Application_Status = params['status']
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
      @application = Application.where.not(Application_Status: "delete")
      @application.Application_Status = "delete"
      @application.save
      redirect_to "/admin/management"
    elsif params['form_type'] == "9"
      Application.where.not(Application_Status: "delete").update_all(Application_Status: 'delete')
      redirect_to "/admin/hiring"
    elsif params['form_type'] == "10"
      @application_opening = SystemValue.find_by(name: 'application_opening')
      @application_opening.value = params['open_for_apply']
      @application_opening.save
      redirect_to "/admin/hiring"
    elsif params['form_type'] == "11"
      @application_opening = SystemValue.find_by(name: 'last_day_interview')
      @application_opening.value = params['date']
      @application_opening.save
      redirect_to "/admin/hiring"
    elsif params['form_type'] == "12"
      @application = Application.where(NUID: params["NUID"]).where.not(Application_Status: "delete").where.not(Application_Status: "withdraw").first
      if @application.blank?
        flash[:notice] = "Application Not Found for NUID: "+params["NUID"]
      else
        if params["date"]!="" and params["time"]!=""
          time = params[:date]+" "+params[:time]+":00"
          @application.Application_Status = "scheduled"
          @application.Interview_Time=time

        end
        if params["score"]!=""
          @application.Score = params["score"]
        end
        if params["application_form"]
          file_name = @application.File_Location
          File.open(Rails.root.join(file_name), 'wb') do |file|
            file.write(params[:application_form].read)
          end
        end
        @application.save
      end

      redirect_to "/admin/hiring"
    end
  end

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end
end