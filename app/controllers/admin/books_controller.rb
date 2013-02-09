# -*- encoding : utf-8 -*-
class Admin::BooksController < Admin::AdminController

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @sort_order = params[:sort_order] || "id"
    @sortables = Book.attribute_names + Book.attribute_names.map{|n| "#{n} DESC"}
    @page = params[:page] || 0
    @books = (params[:search] ? Book.search(params[:search]) : Book).order(@sort_order).page(@page)
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

  def delete_reservation
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to :back, notice: 'Die Reservierung wurde gelöscht'
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to admin_books_path, notice: "Buch wurde erstellt!"
    else
      redirect_to :back, notice: "Das Buch konnte nicht gespeichert werden."
    end
  end

  def new_reservation
    @reservation = Reservation.new
    @reservation.book_id = params[:id]
    @reservation.borrower_id = session[:last_borrower] || Borrower.order(:name).first
  end

  def create_reservation
    @reservation = Reservation.new params[:reservation]

    if @reservation.save
      redirect_to :back, notice: "#{@reservation.book.titel} wurde für #{@reservation.borrower.name} vorgemerkt!"
    else
      redirect_to :back, notice: "Das Buch konnte nicht vorgemerkt werden."
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path, notice: 'Buch wurde gelöscht'
  end

  def add_to_collection
    @book = Book.find(params[:id])
    @collections = Collection.all
  end

  def add_all_to_collection
    @search = params[:search]
    @count = Book.search(@search).count
    @collections = Collection.all
  end  

  def put_all_into_collection
    @books = Book.search(params[:book_for_collection][:search])
    if params[:book_for_collection][:new_collection_name].strip != "" 
      @collection = Collection.new(:name => params[:book_for_collection][:new_collection_name].strip)
    else
      @collection = Collection.find(params[:book_for_collection][:collection_id])
    end

    @collection.books << @books
    @collection.save

    redirect_to :back, :notice => "Zur Sammlung #{@collection.name} hinzugefügt."
  end

  def put_into_collection
    @book = Book.find(params[:id])
    if params[:book_for_collection][:new_collection_name].strip != "" 
      @collection = Collection.new(:name => params[:book_for_collection][:new_collection_name].strip)
    else
      @collection = Collection.find(params[:book_for_collection][:collection_id])
    end

    @collection.books << @book
    @collection.save

    redirect_to :back, :notice => "Zur Sammlung #{@collection.name} hinzugefügt."
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
    @next_borrower = @book.next_reservation ? @book.next_reservation.borrower : nil
    @next_borrower_id = @next_borrower && @next_borrower.id
    @lending.borrower_id = @next_borrower_id || session[:last_borrower] || Borrower.order(:name).first.id
  end

  def create_lending
    @lending = Lending.new(params[:lending])
    session[:last_borrower] = @lending.borrower.id
    if @lending.save
      @lending.borrower.remove_reservations(@lending.book)
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

  def next_free_signature
    @free = Book.next_free_signature params[:signature]
    respond_to do |f|
      f.json {render :json => {:next_free_signature => @free}}
      f.js
    end
  end

end
