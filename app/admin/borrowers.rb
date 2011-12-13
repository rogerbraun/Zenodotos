#encoding: utf-8
ActiveAdmin.register Borrower do
  index do
    column :id
    column :name
    column :email
    column :matrikelnr
    default_actions
  end

  sidebar :actions, :only => :show do 
    button_to "Alle Bücher zurückgeben", return_all_books_admin_borrower_path, :id => "return_all_books"
  end

  member_action :return_all_books, :method => :post do
    borrower = Borrower.find(params[:id])
    borrower.return_all_books
    redirect_to admin_borrower_path(borrower), :notice => "Bücher wurden zurückgegeben"
  end

end
