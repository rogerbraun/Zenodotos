# -*- encoding : utf-8 -*-
class BooksController < ApplicationController

  before_filter :authenticate_admin_user!
  layout "admin"

  def index
    @page = params[:page] || 0
    @books = (params[:search] ? Book.search(params[:search]) : Book).page(@page)
  end

  def edit
    @book = Book.find(params[:id])
  end
end
