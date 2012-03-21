# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  extend Picky::Client::ActiveRecord.configure(host: 'localhost', port: 9292, path: '/')
  has_paper_trail
  paginates_per 10
  has_many :lendings

  has_and_belongs_to_many :collections

  after_initialize :init

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end

  def borrower
    current_lending ? current_lending.borrower.name : "nicht entliehen"
  end

  def self.search keys
    # TODO: Find out how to tell Picky to get all ids
    res = BookSearch.search(:query => keys, :ids => 1000000)
    res.extend Picky::Convenience 
    ids = res.ids(1000000)
    Book.where("id in (?)", ids)
  end

  def self.next_free_signature signature
    @books = Book.where("signatur like ?", "#{signature}%").order("signatur DESC")
    @books.reject!{|book| book.signatur.strip[-1] == "-"}
    @numbers = @books.map{|book| book.signatur.split("-").last.to_i}
    @numbers.max + 1
  end

  private
  
  def init
    self.signatur ||= "Signatur folgt."
    self.aufnahmedatum ||= Date.today
  end

end
