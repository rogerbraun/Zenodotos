# -*- encoding : utf-8 -*-
class BooksController < ApplicationController

  before_filter :authenticate_admin_user!
  layout "admin"

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @page = params[:page] || 0
    @books = (params[:search] ? Book.search(params[:search]) : Book).page(@page)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def new
    if params[:dup_id]
      @book = Book.find(params[:dup_id]).dup
    else
      @book = Book.new
    end
  end

  def new_lending
    @book = Book.find(params[:id])
    @lending = @book.lendings.new
    @lending.return_date = Date.today + 28.days
    @lending.borrower_id = session[:last_borrower]
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

  def show
    # Braucht man wirklich show und edit?
    redirect_to :action => "edit"
  end
end
