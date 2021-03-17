class Applicant::ScheduleInterviewController < ApplicationController

  def create
    time = "#{params[:date]} #{params[:time]}"
    timeCheck = time.to_time
    application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: 'scheduling').first
    if timeCheck.to_date.past?
      flash[:error] = "The time you entered is in the past. You entered: #{time}"
      redirect_to student_application_url
    elsif timeCheck.today?
      flash[:error] = "You can only schedule to the next business day. You entered: #{time}"
      redirect_to student_application_url
    elsif timeCheck.to_date > SystemValue.find_by(name: 'last_day_interview').value.to_date
      flash[:error] = "You can not schedule after the deadline. The deadline is #{SystemValue.find_by(name: 'last_day_interview').value}. You entered #{params[:date]}"
      redirect_to student_application_url
    elsif timeCheck.between?('08:00', '17:00')
      flash[:error] = "Time can only be 08:00 to 17:00, you entered: #{params[:time]}"
      redirect_to student_application_url
    elsif application.nil?
      flash[:error] = 'You are not allow to schedule at this time (application status not to find).'
      redirect_to student_application_url
    else
      application.Application_Status = 'scheduled'
      application.Interview_Time = time
      EmailMailer.scheduled_applicant(application).deliver_now
      EmailMailer.new_scheduled_applicant(application).deliver_now
      application.save
      flash[:success] = "Successfully schedule the interview time to #{time}."
      redirect_to student_application_url
    end
  end
end
