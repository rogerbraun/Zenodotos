# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  helper_method :search_condition, :search_hash
  def index
    @page = params[:page] || 1
    @total_amount = Book.search(params[:search]).length
    @books = Book.search(params[:search]).page(@page)
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def advanced_search
    #@options = Book.attribute_names 
    @options = PARSE_OPTIONS.keys
  end

  def advanced_search_results
    @page = params[:page] || 1
    books = Book.where(search_condition(params), search_hash(params))
    @books = books.page(@page)
    @total_amount = books.length
  end

  private 
  PARSE_OPTIONS = {"Titel" => ["titel", "titel_japanisch"], "Autor/Hrsg" => ["autor", "autor_japanisch"], "Signatur" => ["signatur"], "ISBN" => ["isbn"], "Jahr" => ["jahr"], "Auflage" => ["auflage"], "Bände" => ["baende"], "Inhalt" => "inhalt", "Sprache" => ["sprache"], "Nebensignatur" => ["nebensignatur"], "Erscheinungsort" => ["ort"], "Reihe" => ["reihe", "reihe_japanisch"], "Verlag" => ["verlag", "verlag_japanisch"], "Standort" => ["standort"], "nacsis_japanisch" => ["nacsis_japanisch"], "nacsis_url" => ["nacsis_url"]} 
  def search_condition(params)
    condition = ""
    0.upto(3) do |num|
      if params["input_field" + num.to_s].strip != ""
        search_option = params["search_field" + num.to_s]
        logic_condition = params["logic_field" + num.to_s]
        next_input = params["input_field" + (num + 1).to_s]
        search_fields = PARSE_OPTIONS[search_option]
        if search_fields
          condition += search_fields.map{|field| field + " LIKE :#{field} "}.join("OR ")
          if num != 3 && next_input.strip != ""
            condition += logic_condition + " "
          end
        end
      end
    end
    condition

  end

  def search_hash(params)
    hash = Hash.new
    0.upto(3) do |num|
        input = params["input_field" + num.to_s]
      if input.strip != ""
        search_option = params["search_field" + num.to_s]
        search_fields = PARSE_OPTIONS[search_option]
        if search_fields
          search_fields.each do |field|
            hash[field.to_sym] = "%#{input}%"
          end
        end
      end
    end
    hash

  end


end
