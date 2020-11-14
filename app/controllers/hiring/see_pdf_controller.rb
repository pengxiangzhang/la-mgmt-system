class Hiring::SeePdfController < ApplicationController
  before_action :check_admin

  def create
    location =
        send_file("#{Rails.root}/" + params[:location],
                  :filename => "LA Application - " + params[:username] + ".pdf",
                  :type => "application/pdf", #for example if pdf
                  :disposition => 'inline')
  end
end