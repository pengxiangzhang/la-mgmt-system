class Appointment::EndApptController < ApplicationController
  before_action :check_la

  def create
    @appointment = Appointment.find_by({ id: params['id'] })
    if @appointment.status != 'Started' || @appointment.la_eduPersonPrincipalName != cas_user || @appointment.eduPersonPrincipalName != cas_user
      flash[:error] = 'You are not allowed to do this action'
      redirect_back(fallback_location: root_path)
    else
      UserDetail.find_by(eduPersonPrincipalName: @appointment.eduPersonPrincipalName).update(hasAppointment: false)
      @appointment.status = 'Closed'
      @appointment.endTime = Time.now
      @appointment.close_reason = "Appointment ended by: #{cas_name}"
      @appointment.save
      # send_interaction(1, 'pzhang13', 'CSCE-155', 'NULL')
      student_id = SurveyUser.find_by(canvas_username: @appointment.eduPersonPrincipalName).username_key
      la_id = SurveyUser.find_by(canvas_username: @appointment.la_eduPersonPrincipalName).username_key
      id = SurveyInteractions.create(la_username_key: la_id, student_username_key: student_id, course: @appointment.class_id, interaction_type: 'appointment', seeking_feedback: '1', time_of_interaction: Time.now)
      EmailMailer.survey(@appointment.displayName, id.interaction_key.to_s, @appointment.email).deliver_now
      flash[:success] = 'Appointment Ended'
      redirect_back(fallback_location: root_path)
    end
  end
end
