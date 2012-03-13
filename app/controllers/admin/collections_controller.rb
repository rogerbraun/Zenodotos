#encoding: utf-8
class Admin::CollectionsController < Admin::AdminController

  def index
    @page = params[:page] || 1
    @collections = Collection.page(@page) 
  end

  def show
    redirect_to :action => :edit
  end

  def edit
    @sort_order = params[:sort_order] || "id"
    @collection = Collection.find(params[:id])
    @page = (params[:page] || 1).to_i
    @books = @collection.books.order(@sort_order).page(@page)
    @sortables = Book.attribute_names + Book.attribute_names.map{|n| "#{n} DESC"}
  end

  def remove_book
    @collection = Collection.find(params[:id])
    @book = Book.find(params[:book_id])
    @collection.books.delete(@book)
    redirect_to :back, :notice => "#{@book.titel} wurde aus der Sammlung entfernt."
  end

  def remove_books
    if params[:delete_up_to] && params[:sort_order]
      up_to = params[:delete_up_to]
      @collection = Collection.find(params[:id])
      to_remove = @collection.books.order(params[:sort_order]).limit(up_to)
      @collection.books.delete to_remove 
    end
    redirect_to admin_collection_path(@collection), :notice => "#{to_remove.size} Bücher wurden aus der Sammlung entfernt"
  end

  def mass_edit
    @book = Book.new
    @book.signatur = nil
    @book.aufnahmedatum = nil
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to admin_collections_path, notice: 'Sammlung wurde gelöscht'
  end

  def do_mass_edit
    changes = params[:book].reject{|k, v| v.strip == ""}
    @collection = Collection.find(params[:id])
    @collection.books.update_all(changes)
    @collection.books.each(&:reindex)
    redirect_to admin_collections_path, notice: "Alle Bücher der Sammlung wurden verändert."
  end

end
