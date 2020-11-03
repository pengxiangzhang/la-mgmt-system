class ApplicantController < ApplicationController
  helper_method :application_form

  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end

  def create
    @submit = params
    if params[:File].present?
      (params[:File] || []).each do |muti|
        File.open(Rails.root.join('storage/application', muti.original_filename), 'wb') do |file|
          file.write(muti.read)
        end
      end
    end

    filename = params[:NUID] + Time.now.strftime("-%Y%m%d%H%M%S")
    # Application.new(NUID: params[:NUID], Name: params[:Name], Email: params[:Email], Course: '', GPA: params[:GPA], file_location: "storage/application/" + filename + ".pdf", application_status: "submitted").save
    # EmailMailer.new_applicant(@submit).deliver_now
    # EmailMailer.thank_applying(@submit).deliver_now
    app1 = WickedPdf.new.pdf_from_string(render_to_string(pdf: 'report1', :template => 'applicant/pdf.html.erb', :layout => 'pdf.html.erb', :page_size => 'letter', :lowquakity => true, :zoom => 1, :dpi => 75))
    combiner = CombinePDF.new
    combiner << CombinePDF.parse(app1)
    combiner.to_pdf
    save_path = Rails.root.join('storage/application', filename + ".pdf")
    File.open(save_path, 'wb') do |file|
      file << combiner
    end
    render "applicant/confirm"
  end

  def ddd
    uploaded_io = params[:picture]
    File.open(Rails.root.join('storage/application', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end
end