class SearchController < ApplicationController
  def index
    @books = Book.quicksearch(params[:q])
    respond_to do |f|
      f.html
    end
  end
end
