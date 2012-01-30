# -*- encoding : utf-8 -*-
class Admin::PrintoutsController < Admin::AdminController
  def index
    @unprinted = Lending.unprinted.count
    @printouts = Printout.order("id DESC")
  end

  def new
    Printout.new_from_unprinted
    redirect_to admin_printouts_path, :notice => "PDF erstellt"
  end

end
