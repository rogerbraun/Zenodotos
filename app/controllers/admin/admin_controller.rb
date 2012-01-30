# -*- encoding : utf-8 -*-
class Admin::AdminController < ApplicationController 
  before_filter :authenticate_admin_user!
  layout "admin"
end
