class ApplicantController < ApplicationController
  helper_method :application_form

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end
  def create
    params.each do |key,value|
      Rails.logger.warn "Param #{key}: #{value}"
    end
  end
end
