class SearchController < ApplicationController
  def index
    @page = params[:page] || 1
    @books = Book.quicksearch(params[:q]).page(@page)
    respond_to do |f|
      f.html
    end
  end
end
