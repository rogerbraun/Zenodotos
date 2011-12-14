class PrintoutsController < ApplicationController
  def index
    @unprinted = Lending.where("printout_id is null").count
    @printouts = Printout.order("id DESC")
  end

  def new
    Printout.new_from_unprinted
    redirect_to printouts_path
  end

end
