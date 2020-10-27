class ApplicantController < ApplicationController
  helper_method :application_form

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end
  def create
    params.each do |key,value|
      Rails.logger.warn "Params #{key}: #{value}"
    end
    @submit = params
    # render "applicant/pdf"
      render pdf: "/Users/pengxiangzhang/Desktop/test",
           page_size: 'A4',
             template: "applicant/pdf.html.erb",
             layout: "pdf.html",
             lowquality: true,
             zoom: 1,
             dpi: 75
  end
end
