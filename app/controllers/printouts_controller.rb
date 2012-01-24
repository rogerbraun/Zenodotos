# -*- encoding : utf-8 -*-
class PrintoutsController < ApplicationController
  def index
    @unprinted = Lending.unprinted.count
    @printouts = Printout.order("id DESC")
  end

  def new
    Printout.new_from_unprinted
    redirect_to printouts_path
  end

end
