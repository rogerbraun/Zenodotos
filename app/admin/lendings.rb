#encoding: utf-8
ActiveAdmin.register Lending do
  scope :overdue

  filter :borrower
  filter :return_date

  index do
    column :book, :sortable => :book do |lending|
      link_to lending.book.titel, admin_book_path(lending.book)
    end
    column :borrower, :sortable => :borrower do |lending|
      link_to lending.borrower.name, admin_borrower_path(lending.borrower)
    end
    column :return_date
    column :returned, :sortable => :returned do |lending|
      lending.returned ? t("yes") : t("no")
    end
  end 

  sidebar :actions do
    button_to "Mahnungen abschicken", send_overdue_reminders_path, :method => :post , :id => "send_overdue_reminders"
  end

  member_action :return, :method => :post do
    lending = Lending.find(params[:id])
    lending.return
    redirect_to admin_book_path(lending.book), :notice => "Buch wurde zurückgegeben"
  end

  controller do
    def user_for_paper_trail
      current_admin_user
    end
  end

end
