# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def index
    @page = params[:page] || 1
    @total_amount = Book.search(params[:search]).length
    @books = Book.search(params[:search]).page(@page)
  end

  def show
    @book = Book.find(params[:id])
  end

end
