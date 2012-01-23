class BooksController < ApplicationController

  before_filter :authenticate_admin_user!
  layout "admin"

  def index
    @page = params[:page] || 0
    @books = Book.page(@page)
  end
end
