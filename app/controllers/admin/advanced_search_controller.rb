# -*- encoding : utf-8 -*-
class Admin::AdvancedSearchController < Admin::AdminController

  def index
    params[:search] = nil if params[:search] and params[:search].strip == ""
    @sort_order = params[:sort_order] || "id"
    @sortables = Book.attribute_names + Book.attribute_names.map{|n| "#{n} DESC"}
    @page = params[:page] || 0
    @books = (params[:search] ? Book.search(params[:search]) : Book).order(@sort_order).page(@page)
    @book = Book.new
    @book.signatur = nil
    @book.aufnahmedatum = nil
  end

  def show_results
    books = params[:book]
    books = books.reject{|k, v| v.strip == ""}
    conditions = books.keys.map{|k| "#{k} LIKE :#{k}"}.join(" AND ");
    hash = Hash.new
    books.each do |k, v|
      hash[k.to_sym] = "%#{v.strip}%"
    end 
    @sort_order = params[:sort_order] || "id"
    @sortables = Book.attribute_names + Book.attribute_names.map{|n| "#{n} DESC"}
    @page = params[:page] || 0
    @results = Book.order(@sort_order).where(conditions, hash).page(@page)
  end

end
