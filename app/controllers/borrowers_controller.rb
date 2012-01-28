# -*- encoding : utf-8 -*-
class BorrowersController < ActionController::Base

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @page = params[:page] || 0
    @borrowers = (params[:search] ? Borrower.search(params[:search]) : Borrower).page(@page)
  end

  def send_overdue_reminders
    if admin_user_signed_in?
      Borrower.send_overdue_reminders
    end
    redirect_to admin_lendings_path, :notice => "Nutzer wurden gemahnt."
  end

end
