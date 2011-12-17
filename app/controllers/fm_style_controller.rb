class FmStyleController < ApplicationController
  def index
    @book = Book.first
  end

end
