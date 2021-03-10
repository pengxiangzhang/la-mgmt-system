class Appointment::ReportIssueController < ApplicationController

  def create
    appt = Appointment.find_by({ id: params['ida'] })
    if appt.nil?
      flash[:error] = 'Appointment not find.'
      redirect_back(fallback_location: root_path)
    elsif appt.eduPersonPrincipalName != cas_user or appt.la_eduPersonPrincipalName != cas_user
      flash[:error] = 'You are not allow to make this change.'
      redirect_back(fallback_location: root_path)
    else
      la = UserDetail.find_by(eduPersonPrincipalName: appt.la_eduPersonPrincipalName).DisplayName
      appt.update({ status: 'Closed', close_reason: "Issue reported by #{params['who']}(#{cas_name}):#{params['reason']}", endTime: Time.now })
      UserDetail.find_by({ eduPersonPrincipalName: appt.eduPersonPrincipalName }).update({ hasAppointment: false })
      EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, cas_name, la, params['reason'], cas_email).deliver_now
      EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, cas_name, la, params['reason'], appt.email).deliver_now
      EmailMailer.appointment_cancel(appt.class_id, appt.the_method, appt.datetime.strftime('%m/%d/%Y %I:%M %P'), appt.duration.to_s, appt.displayName, cas_name, la, params['reason'], SystemValue.find_by(name: 'admin_email').value).deliver_now
      flash[:success] = 'You issue has been reported.'
      redirect_back(fallback_location: root_path)
    end
  end
end