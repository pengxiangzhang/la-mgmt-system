class Applicant::ScheduleInterviewController < ApplicationController

  def create
    time = "#{params[:date]} #{params[:time]}"
    timeCheck = time.to_time
    application = Application.where(eduPersonPrincipalName: cas_user).where(Application_Status: 'scheduling').first
    if timeCheck.to_date.past?
      flash[:info] = "The time you entered is in the past. You entered: #{time}"
      redirect_to student_application_url
    elsif timeCheck.today?
      flash[:info] = "You can only schedule to the next business day. You entered: #{time}"
    elsif timeCheck.to_date > SystemValue.find_by(name: 'last_day_interview').value.to_date
      flash[:info] = "You can not schedule after the deadline. The deadline is #{SystemValue.find_by(name: 'last_day_interview').value}. You entered #{params[:date]}"
    elsif timeCheck.between?('08:00', '17:00')
      flash[:info] = "Time can only be 08:00 to 17:00, you entered: #{params[:time]}"
    elsif application.nil?
      flash[:info] = 'You are not allow to schedule at this time (application status not to find).'
    else
      application.Application_Status = 'scheduled'
      application.Interview_Time = time
      EmailMailer.scheduled_applicant(application).deliver_now
      EmailMailer.new_scheduled_applicant(application).deliver_now
      application.save
      flash[:success] = "Successfully schedule the interview time to #{time}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Schedule Interview Application] User schedule interview '#{time}'.")
    end
    redirect_to student_application_url
  end
end
