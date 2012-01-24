# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def index
    @page = params[:page] || 1
    @books = Book.search(params[:search]).page(@page)
  end
end
