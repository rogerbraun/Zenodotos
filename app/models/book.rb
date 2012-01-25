# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  require 'picky'
  has_paper_trail
  paginates_per 10
  has_many :lendings

  after_initialize :init
  after_save :reindex #unless Rails.env == "test"

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end

  def reindex
    BookIndex.replace self
  end

  def self.quicksearch q
    query = "%#{q}%"
    Book.where("autor like ? or autor_japanisch like ? or titel like ? or titel_japanisch like ?", query, query, query, query)
  end

  def self.reindex
    self.all.each do |book|
      book.reindex
    end
    true
  end

  def self.search keys
    # TODO: Find out how to tell Picky to get all ids
    ids = (BookSearch.search keys, 1000000).ids(1000000)
    Book.where("id in (?)", ids)
  end

  private
  
  def init
    self.signatur ||= "Signatur folgt."
    self.aufnahmedatum ||= Date.today
  end

end
