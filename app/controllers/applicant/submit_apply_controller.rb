class Applicant::SubmitApplyController < ApplicationController
  before_action :check_block

  def accept_application
    SystemValue.find_by(name: 'application_opening')
  end

  def create
    if !Application.where({ eduPersonPrincipalName: cas_user }).where.not(Application_Status: 'withdraw').where.not(Application_Status: 'delete').blank?
      flash[:info] = 'You already have an application.'
    elsif check_file(params)
      flash[:info] = 'The file you upload if larger than 3MB.'
    elsif accept_application.value != 'false'
      @submit = params
      @username = cas_user
      @name = cas_name
      tmpfilename = SecureRandom.uuid
      filename = params[:NUID] + Time.now.strftime('-%Y%m%d%H%M%S')
      pdf = WickedPdf.new.pdf_from_string(render_to_string(template: 'student/pdf.html.erb', layout: 'pdf.html.erb', page_size: 'letter', lowquakity: true, zoom: 1, dpi: 75))
      save_path = Rails.root.join('storage/application', "#{filename}.pdf")
      File.open(Rails.root.join("tmp/#{tmpfilename}.pdf"), 'wb') do |file|
        file << pdf
      end
      pdf = CombinePDF.new
      pdf << CombinePDF.load(Rails.root.join("tmp/#{tmpfilename}.pdf"))
      if params[:file].present?
        (params[:file] || []).each do |muti|
          File.open(Rails.root.join("tmp/#{tmpfilename}.pdf"), 'wb') do |file|
            file.write(muti.read)
            pdf << CombinePDF.load(Rails.root.join("tmp/#{tmpfilename}.pdf"))
          end
        end
      end
      pdf.save save_path
      File.delete(Rails.root.join("tmp/#{tmpfilename}.pdf")) if File.exist?(Rails.root.join("tmp/#{tmpfilename}.pdf"))
      Application.new({ eduPersonPrincipalName: @username, NUID: params[:NUID], Name: @name, Email: params[:Email], Course: params[:Course], GPA: params[:GPA], Score: 0, File_Location: "storage/application/#{filename}.pdf", Application_Status: 'submitted' }).save
      EmailMailer.new_applicant(@submit).deliver_now
      EmailMailer.thank_applying(@submit).deliver_now
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Submit Application] User submit application.")
    else
      flash[:info] = 'Application is currently closed.'
    end
    redirect_to student_application_url
  end
end