class Applicant::ScheduleInterviewController < ApplicationController

  def create
    time = params[:date] + " " + params[:time]
    if time < (Time.now + 30.minute)
      flash[:error] = "The time you entered is in the past or in the next 30 minutes. You entered: " + time
      redirect_to student_application_url
    elsif params[:date].to_date > SystemValue.find_by(name: 'last_day_interview').value.to_date
      flash[:error] = "You can not schedule after the deadline. The deadline is " + SystemValue.find_by(name: 'last_day_interview').value + ". You entered " + params[:date]
      redirect_to student_application_url
    elsif time.between?("08:00", "17:00")
      flash[:error] = "Time can only be 08:00 to 17:00, you entered: " + params[:time]
      redirect_to student_application_url
    else
      application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: "scheduling").first
      if application.nil?
        flash[:error] = "You are not allow to schedule at this time (application status not to find)."
        redirect_to student_application_url
      else
        application.Application_Status = "scheduled"
        application.Interview_Time = time
        EmailMailer.scheduled_applicant(application).deliver_now
        EmailMailer.new_scheduled_applicant(application).deliver_now
        application.save
        flash[:success] = "Successfully schedule the interview time to " + time + "."
        redirect_to student_application_url
      end
    end
  end
end
