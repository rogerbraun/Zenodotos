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

  def show
    # Braucht man wirklich show und edit?
    redirect_to :action => "edit"
  end
end
