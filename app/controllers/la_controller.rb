class LaController < ApplicationController
  before_action :check_la

  def settings
    @la = LaDetail.find_by(eduPersonPrincipalName: cas_user)
  end
end
