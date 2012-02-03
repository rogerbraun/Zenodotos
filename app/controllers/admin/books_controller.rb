# -*- encoding : utf-8 -*-
class Admin::BooksController < Admin::AdminController

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @page = params[:page] || 0
    @books = (params[:search] ? Book.search(params[:search]) : Book).page(@page)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def duplicate
    @book = Book.find(params[:id]).dup
    render "new"
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to admin_books_path, notice: "Buch wurde erstellt!"
    else
      redirect_to :back, notice: "Das Buch konnte nicht gespeichert werden."
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book]) then
      redirect_to admin_books_path, notice: "Buch wurde gespeichert!"
    else
      redirect_to edit_admin_book_path(@book), notice: "Buch konnte nicht gespeichert werden."
    end
  end
    

  def return_book
    @book = Book.find(params[:id])
    @book.current_lending.return
    flash[:notice] = "'#{@book.titel}' wurde zurück gegeben."

    redirect_to :back
  end

  def new_lending
    @book = Book.find(params[:id])
    @lending = @book.lendings.new
    @lending.return_date = Date.today + 28.days
    @lending.borrower_id = session[:last_borrower] || Borrower.order(:name).first
  end

  def create_lending
    @lending = Lending.new(params[:lending])
    session[:last_borrower] = @lending.borrower.id
    if @lending.save
      flash[:notice] = "'#{@lending.book.titel}' wurde verliehen"
    else
      flash[:error] = "Buch wurde nicht verliehen"
    end
    redirect_to :back
  end

  def extend_current_lending
    @book = Book.find(params[:id])
    @book.current_lending.extend_date
    flash[:notice] = "'#{@book.titel}' wurde verlängert."

    redirect_to :back
  end

  def show
    # Braucht man wirklich show und edit?
    redirect_to :action => "edit"
  end
end
