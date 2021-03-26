class Hiring::ApplicationNoteController < ApplicationController
  before_action :check_admin
  skip_before_action :verify_authenticity_token

  def create
    @application = Application.where({ eduPersonPrincipalName: params['username'] }).where.not({ Application_Status: 'delete' }).where.not({ Application_Status: 'withdraw' }).first
    if @application.nil?
      flash[:info] = "Application Not Found for username: #{params["username"]}"
    elsif check_file(params)
      flash[:info] = 'The file you upload if larger than 3MB.'
    else
      tmpfilename = SecureRandom.uuid
      @submit = params
      @username = cas_user
      @name = cas_name
      @student_name = @application.Name
      @student_username = @application.eduPersonPrincipalName
      file_name = @application.File_Location
      @application.Score = @application.Score + params['Score'].to_i
      note = WickedPdf.new.pdf_from_string(render_to_string(template: 'admin/interview_note.html.erb', layout: 'pdf.html.erb', page_size: 'letter', lowquakity: true, zoom: 1, dpi: 75))
      File.open(Rails.root.join("tmp/#{tmpfilename}.pdf"), 'wb') do |file|
        file << note
      end
      pdf = CombinePDF.new
      pdf << CombinePDF.load(Rails.root.join(file_name))
      pdf << CombinePDF.load(Rails.root.join("tmp/#{tmpfilename}.pdf"))
      if params[:file].present?
        (params[:file] || []).each do |muti|
          File.open(Rails.root.join("tmp/#{tmpfilename}.pdf"), 'wb') do |file|
            file.write(muti.read)
            pdf << CombinePDF.load(Rails.root.join("tmp/#{tmpfilename}.pdf"))
          end
        end
      end
      pdf.save file_name
      File.delete(Rails.root.join("tmp/#{tmpfilename}.pdf")) if File.exist?(Rails.root.join("tmp/#{tmpfilename}.pdf"))
      @application.save
      flash[:success] = "Successfully change note for User:#{@student_username}."
      ActionLogger.info("[User: #{cas_user}|IP:#{request.ip}|Application Note] Add application note to '#{@student_username}'.")
    end
    redirect_to admin_hiring_url
  end
end
