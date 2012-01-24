# -*- encoding : utf-8 -*-
class FmStyleController < ApplicationController
  def index
    @book = Book.first
  end

end
