# -*- encoding : utf-8 -*-
class Admin::CoworkersController < Admin::AdminController

  def index
    @coworkers = AdminUser.all
  end

  def new
    @coworker = AdminUser.new
  end

  def create
    @coworker = AdminUser.new(params[:admin_user])
    if @coworker.save
      redirect_to admin_coworkers_path, notice: "Mitarbeiter gespeichert."
    else
      redirect_to :back, notice: "Mitarbeiter konnte nicht gespeichert werden."
    end
  end

  def destroy
    @coworker = AdminUser.find(params[:id])
    @coworker.destroy
    redirect_to admin_coworkers_path, notice: "Mitarbeiter wurde gelöscht."
  end

end
