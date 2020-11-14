class Hiring::DeleteAllController < ApplicationController
  def create
    Application.where.not(Application_Status: "delete").update_all(Application_Status: 'delete')
    redirect_to Rails.configuration.custom_prefix + "/admin/hiring"
  end
end
