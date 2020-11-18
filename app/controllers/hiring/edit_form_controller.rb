class Hiring::EditFormController < ApplicationController
  before_action :check_admin

  def create
    @form = FormBuilder.find_by(formname: 'application')
    @form.formdata = params['saveform']
    @form.save
    redirect_to admin_hiring_url
  end

end
