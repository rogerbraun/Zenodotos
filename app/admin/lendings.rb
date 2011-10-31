ActiveAdmin.register Lending do
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
end
