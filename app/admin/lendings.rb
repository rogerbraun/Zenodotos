ActiveAdmin.register Lending do
  scope :overdue

  index do
    column :book, :sortable => :book do |lending|
      link_to lending.book.titel, admin_book_path(lending.book)
    end
    column :borrower, :sortable => :borrower do |lending|
      link_to lending.borrower.name, admin_borrower_path(lending.borrower)
    end
    column :return_date
    column :returned
  end 

  sidebar :actions do
    link_to "Mahnungen abschicken", send_overdue_reminders_path, :method => :post , :id => "send_overdue_reminders"
  end
end
