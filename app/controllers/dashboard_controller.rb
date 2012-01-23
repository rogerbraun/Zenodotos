class DashboardController < ApplicationController
  before_filter :authenticate_admin_user!
  layout "admin"

  def index
  end
end
