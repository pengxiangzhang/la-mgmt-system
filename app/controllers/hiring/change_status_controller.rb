class Hiring::ChangeStatusController < ApplicationController
  before_action :check_admin

  def create
    if params['status'].empty?
      flash[:error] = 'Error: You must select a status.'
      redirect_to admin_hiring_url
    elsif params['email'] != "skip" && params['template_email'].empty?
      flash[:error] = 'Error: You must select a email template.'
      redirect_to admin_hiring_url
    else
      @application = Application.find_by({ id: params['id'] })
      @application.Application_Status = params['status']
      unless params['sub-status'].empty?
        @application.Sub_Status = params['sub-status']
      end
      @application.save
      @cc = params['cc_email'].split(',') unless params['cc_email'].empty?
      @name = @application.Name
      @username = @application.eduPersonPrincipalName
      @to = params['to_email']
      @subject = params['subject_email']
      @content = params['content']
      @by = cas_name
      if params['email'] == "queue"
        File.open("storage/send_later/" + Time.now.to_i.to_s, 'a') do |file|
          file.puts @application.NUID
          file.puts @to
          file.puts @cc
          file.puts params['subject_email']
          file.puts params['content']
        end
        flash[:success] = "Successfully change status for: #{@application.Name} to #{params['status']}. Email queued."
      elsif params['email'] == "now"
        EmailMailer.template(@to, @cc, params['subject_email'], params['content']).deliver_now
        flash[:success] = "Successfully change status for: #{@application.Name} to #{params['status']}. Email Sended."
      else
        flash[:success] = "Successfully change status for: #{@application.Name} to #{params['status']}. No email sended."
      end
      tmpfilename = SecureRandom.uuid
      file_name = @application.File_Location
      email = WickedPdf.new.pdf_from_string(render_to_string(:template => 'admin/email.html.erb', :layout => 'pdf.html.erb', :page_size => 'letter', :lowquakity => true, :zoom => 1, :dpi => 75))
      File.open(Rails.root.join("tmp/" + tmpfilename + ".pdf"), 'wb') do |file|
        file << email
      end
      pdf = CombinePDF.new
      pdf << CombinePDF.load(Rails.root.join(file_name))
      pdf << CombinePDF.load(Rails.root.join("tmp/" + tmpfilename + ".pdf"))
      pdf.save file_name
      File.delete(Rails.root.join("tmp/" + tmpfilename + ".pdf")) if File.exist?(Rails.root.join("tmp/" + tmpfilename + ".pdf"))

      redirect_to admin_hiring_url
    end
  end
end