class ApplicantProcessController < ApplicationController

  def create
    if params['form_type'] == "1"
      @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
      @application.Application_Status = "withdraw"
      @application.save
      redirect_to(student_application_url)
    elsif params['form_type'] == "2"
      if params[:date].to_date < Date.today
        flash[:notice] = "You can not schedule before today. Today is " + Date.today.to_s + ". You entered " + params[:date]
        redirect_to(student_application_url)
      elsif params[:date].to_date > SystemValue.find_by(name: 'last_day_interview').value.to_date
        flash[:notice] = "You can not schedule after the deadline. The deadline is " + SystemValue.find_by(name: 'last_day_interview').value + ". You entered " + params[:date]
        redirect_to(student_application_url)
      elsif "08:00" < params[:time].to_time and params[:time].to_time < "17:00"
        flash[:notice] = "Time can only be 08:00 to 17:00, you entered: " + params[:time]
        redirect_to(student_application_url)
      else
        @application = Application.where(eduPersonPrincipalName: cas_user).where.not(Application_Status: "withdraw").where.not(Application_Status: "delete").first
        time = params[:date] + " " + params[:time] + ":00"
        @application.Application_Status = "scheduled"
        @application.Interview_Time = time
        @application.save
        redirect_to(student_application_url)
      end
    end

  end
end
