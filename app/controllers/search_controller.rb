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
  
  def advanced_search
    @options = Book.attribute_names 
  end

  def advanced_search_results
    condition = ""
    hash = Hash.new
    0.upto(3) do |num|
      if params["input_field" + num.to_s].strip != ""
        hash[params["search_field" + num.to_s].to_sym] = "%#{params['input_field' + num.to_s]}%"
        condition += params["search_field" + num.to_s] + " LIKE :#{params["search_field" + num.to_s]} "
        if num != 3 && params["input_field" + (num + 1).to_s].strip != ""
          condition += params["logic_field" + num.to_s] + " "
        end
      end
    end
    @page = params[:page] || 1
    books = Book.where(condition, hash)
    @books = books.page(@page)
    @total_amount = books.length
  end

end
