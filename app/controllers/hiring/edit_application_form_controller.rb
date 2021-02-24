class Hiring::EditApplicationFormController < ApplicationController
  before_action :check_admin

  def create
    @form = FormBuilder.find_by(formname: 'application')
    @form.formdata = params['saveform']
    @form.save
    flash[:success] = "Successfully update the application form."
    redirect_to admin_hiring_url
  end

end
