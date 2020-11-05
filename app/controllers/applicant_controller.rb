class ApplicantController < ApplicationController
  helper_method :application_form
  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end
  def application_form
    Formbuilder.find_by(formname: 'application')['formdata']
  end

  def create
    if accept_application.value == "true"
    @submit = params
    filename = params[:NUID] + Time.now.strftime("-%Y%m%d%H%M%S")
    Application.new(eduPersonPrincipalName: params[:Username], NUID: params[:NUID], Name: params[:Name], Email: params[:Email], Course: params[:Course], GPA: params[:GPA], file_location: "storage/application/" + filename + ".pdf", application_status: "submitted").save
    # EmailMailer.new_applicant(@submit).deliver_now
    # EmailMailer.thank_applying(@submit).deliver_now
    pdf = WickedPdf.new.pdf_from_string(render_to_string(:template => 'applicant/pdf.html.erb', :layout => 'pdf.html.erb', :page_size => 'letter', :lowquakity => true, :zoom => 1, :dpi => 75))
    save_path = Rails.root.join('storage/application', filename + ".pdf")
    File.open(Rails.root.join('tmp/pdf/', "tmp.pdf"), 'wb') do |file|
      file << pdf
    end
    pdf = CombinePDF.new
    pdf << CombinePDF.load(Rails.root.join("tmp/pdf/", "tmp.pdf"))
    if params[:File].present?
      (params[:File] || []).each do |muti|
        File.open(Rails.root.join('tmp/pdf/', "tmp.pdf"), 'wb') do |file|
          file.write(muti.read)
          pdf << CombinePDF.load(Rails.root.join("tmp/pdf/", "tmp.pdf"))
        end
      end
    end
    pdf.save save_path
    redirect_to(student_application_url)
    else
      redirect_to(student_application_url)
    end
  end
end