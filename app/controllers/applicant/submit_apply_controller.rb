class Applicant::SubmitApplyController < ApplicationController

  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end

  def create
    if accept_application.value != "false"
      @submit = params
      tmpfilename = SecureRandom.uuid
      filename = params[:NUID] + Time.now.strftime("-%Y%m%d%H%M%S")
      Application.new(eduPersonPrincipalName: params[:Username], NUID: params[:NUID], Name: params[:Name], Email: params[:Email], Course: params[:Course], GPA: params[:GPA], File_Location: "storage/application/" + filename + ".pdf", Application_Status: "submitted").save
      # TODO uncomment email
      # EmailMailer.new_applicant(@submit).deliver_now
      # EmailMailer.thank_applying(@submit).deliver_now
      pdf = WickedPdf.new.pdf_from_string(render_to_string(:template => 'student/pdf.html.erb', :layout => 'pdf.html.erb', :page_size => 'letter', :lowquakity => true, :zoom => 1, :dpi => 75))
      save_path = Rails.root.join('storage/application', filename + ".pdf")
      File.open(Rails.root.join("tmp/"+tmpfilename+".pdf"), 'wb') do |file|
        file << pdf
      end
      pdf = CombinePDF.new
      pdf << CombinePDF.load(Rails.root.join("tmp/"+tmpfilename+".pdf"))
      if params[:File].present?
        (params[:File] || []).each do |muti|
          File.open(Rails.root.join("tmp/"+tmpfilename+".pdf"), 'wb') do |file|
            file.write(muti.read)
            pdf << CombinePDF.load(Rails.root.join("tmp/"+tmpfilename+".pdf"))
          end
        end
      end
      pdf.save save_path
      File.delete(Rails.root.join("tmp/"+tmpfilename+".pdf")) if File.exist?(Rails.root.join("tmp/"+tmpfilename+".pdf"))
      redirect_to student_application_url
    else
      flash[:error] = "Application is currently closed."
      redirect_to student_application_url
    end
  end
end
