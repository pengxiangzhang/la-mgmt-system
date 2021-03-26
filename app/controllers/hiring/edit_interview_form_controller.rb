class Hiring::EditInterviewFormController < ApplicationController
  before_action :check_admin

  def create
    @form = FormBuilder.find_by(formname: 'interview')
    @form.formdata = params['saveform']
    @form.save
    flash[:success] = 'Successfully update the interview form.'
    ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Update Interview Form] Change interview form.")
    redirect_to admin_hiring_url
  end

end
