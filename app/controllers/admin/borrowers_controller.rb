# -*- encoding : utf-8 -*-
class Admin::BorrowersController < ActionController::Base

  layout "admin"

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @page = params[:page] || 0
    @borrowers = (params[:search] ? Borrower.search(params[:search]) : Borrower).page(@page)
    flash[:notice] = "Nichts gefunden..." if @borrowers.size == 0
  end

  def send_overdue_reminders
    if admin_user_signed_in?
      Borrower.send_overdue_reminders
    end
    redirect_to admin_lendings_path, :notice => "Nutzer wurden gemahnt."
  end

end
