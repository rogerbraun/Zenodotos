class SearchController < ApplicationController
  def index
    @page = params[:page] || 1
    @books = Book.search(params[:q]).page(@page)
  end
end
