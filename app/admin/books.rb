#encoding: utf-8
ActiveAdmin.register Book do

  index do
    column :id
    column :titel
    column :autor
    column :signatur
    column :nebensignatur
    column :created_at

    default_actions
  end

  sidebar "Aktionen", :only => :show do
    book = Book.find(params[:id])
    unless book.current_lending

      @lending = Lending.new
      @lending.book = book
      @lending.return_date = 1.month.from_now
      render :partial => "lending", :locals => {lending: @lending}
    else
      render :partial => "return_lending", :locals => {lending: book.current_lending}
      #button_to "Zurückgeben", return_admin_lending_path(book.current_lending), :id => "return_book"
    end
  end

  member_action :lend, :method => :post do
    book = Book.find(params[:id])
    lending = Lending.create(params[:lending])
    unless lending.id
      redirect_to admin_book_path(book), :notice => "Buch wurde nicht verliehen."
    else
      redirect_to admin_book_path(book), :notice => "Buch wurde verliehen!"
    end
  end

  controller do
    def user_for_paper_trail
      current_admin_user
    end
  end
  
end
