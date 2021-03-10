class Hiring::GetTemplateController < ApplicationController
  before_action :check_admin

  def create
    @applicant = Application.find_by({ id: params[:id] })
    @name = @applicant.Name
    html = File.open("app/views/email_mailer/template/#{params['template']}").read
    template = ERB.new(html)
    template1 = template.result(binding)

    respond_to do |format|
      format.json { render json: { 'content' => template1 } }
    end
  end
end
