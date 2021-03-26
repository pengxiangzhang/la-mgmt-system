class Management::ExportLogController < ApplicationController
  def create
    redirect_to admin_export_url start: params['start'], end: params['end']
  end
end
