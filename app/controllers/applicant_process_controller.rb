class ApplicantProcessController < ApplicationController

  def create
    if params['form_type'] == "1"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
      @application.Application_Status = "withdraw"
      @application.save
      redirect_to Rails.configuration.custom_prefix+"/student/application"
    elsif params['form_type'] == "2"
      time = params[:date] + " " + params[:time] + ":00"
      if time < (Time.now + 30.minute)
        flash[:notice] = "The time you entered is in the past or in the next 30 minutes. You entered: " + time
        redirect_to Rails.configuration.custom_prefix+"/student/application"
      elsif params[:date].to_date > SystemValue.find_by(name: 'last_day_interview').value.to_date
        flash[:notice] = "You can not schedule after the deadline. The deadline is " + SystemValue.find_by(name: 'last_day_interview').value + ". You entered " + params[:date]
        redirect_to Rails.configuration.custom_prefix+"/student/application"
      elsif time.between?("08:00", "17:00")
        flash[:notice] = "Time can only be 08:00 to 17:00, you entered: " + params[:time]
        redirect_to Rails.configuration.custom_prefix+"/student/application"
      else
        @application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: "scheduling").first
        @application.Application_Status = "scheduled"
        @application.Interview_Time = time
        @application.save
        EmailMailer.scheduled_applicant(@application).deliver_now
        EmailMailer.new_scheduled_applicant(@application).deliver_now
        redirect_to Rails.configuration.custom_prefix+"/student/application"
      end
    elsif params['form_type'] == "3"
      @application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: "offered").first
      @application.Application_Status = "accepted"
      @application.save
      EmailMailer.scheduled_applicant(@application).deliver_now
      redirect_to Rails.configuration.custom_prefix+"/student/application"
    end
  end
end
