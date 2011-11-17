class BorrowersController < ActionController::Base

  def send_overdue_reminders
    if admin_user_signed_in?
      Borrower.send_overdue_reminders
    end
    redirect_to admin_lendings_path, :notice => "Nutzer wurden gemahnt."
  end

end
