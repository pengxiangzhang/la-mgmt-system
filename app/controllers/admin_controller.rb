class AdminController < ApplicationController
  before_action :check_admin
  helper_method :application_form, :hiring_email, :system_url, :application_form

  def application_form
    FormBuilder.find_by(formname: 'application')['formdata']
  end

  def management
    @users = UserDetail.all
  end

  def hiring_email
    SystemValue.find_by(name: 'application_email')
  end

  def hiring
    @application = Application.where.not(Application_Status: "delete")
  end

  def system_url
    SystemValue.find_by(name: 'system_url')
  end

  def application_form
    FormBuilder.find_by(formname: 'application')['formdata']
  end

  def courses
    @courses = Course.all.order(:course_name)
  end
end