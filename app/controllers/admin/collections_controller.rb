#encoding: utf-8
class Admin::CollectionsController < Admin::AdminController

  def index
    @page = params[:page] || 0
    @collections = Collection.page(@page) 
  end

  def show
    redirect_to :action => :edit
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def remove_book
    @collection = Collection.find(params[:id])
    @book = Book.find(params[:book_id])
    @collection.books.delete(@book)
    redirect_to :back, :notice => "#{@book.titel} wurde aus der Sammlung entfernt."
  end

  def mass_edit
    @book = Book.new
    @book.signatur = nil
    @book.aufnahmedatum = nil
  end

  def do_mass_edit
    changes = params[:book].reject{|k, v| v.strip == ""}
    @collection = Collection.find(params[:id])
    @collection.books.update_all(changes)
    redirect_to admin_collections_path, notice: "Alle Bücher der Sammlung wurden verändert."
  end

end
