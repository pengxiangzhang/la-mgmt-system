class InterviewerController < ApplicationController
  before_action :check_admin
  helper_method :application_form

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end

  def new_form
    Formbuilder.new(formname: 'application', formdata: '[{"type":"text","label":"Full Name","subtype":"text","className":"form-control","name":"text-1476748004559"},{"type":"select","label":"Occupation","className":"form-control","name":"select-1476748006618","values":[{"label":"Street Sweeper","value":"option-1","selected":true},{"label":"Moth Man","value":"option-2"},{"label":"Chemist","value":"option-3"}]},{"type":"textarea","label":"Short Bio","rows":"5","className":"form-control","name":"textarea-1476748007461"}]').save
  end

  def create
    @form = Formbuilder.find_by(formname: 'application')
    @form.formdata = params['saveform']
    @form.save
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
