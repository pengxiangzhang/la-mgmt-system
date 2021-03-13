class Hiring::EditContactFormController < ApplicationController
  before_action :check_admin

  def create
    @form = FormBuilder.find_by(formname: 'contact')
    @form.formdata = params['saveform']
    @form.save
    flash[:success] = 'Successfully update the interview form.'
    redirect_to admin_hiring_url
  end

end
