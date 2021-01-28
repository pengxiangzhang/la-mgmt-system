class Management::ChangeOfficeHourController < ApplicationController
  before_action :check_admin

  def create
    @la = LaDetail.find_by(id: params['id'])
    p "haha"
    p @la.inspect
    p params['status']
    @la.allowChangeHour = params['status']
    @la.save
    p @la.inspect
    flash[:success] = "Successfully change to allow " + @la.name.to_s + " to change office hour to " + params['status']
    redirect_to admin_courses_url
  end

  def update
    LaDetail.all.update_all(allowChangeHour: 'true')
    flash[:success] = "Successfully change to allow all LA to change office hour."
    redirect_to admin_courses_url
  end
end
