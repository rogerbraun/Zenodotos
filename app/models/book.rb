# -*- encoding : utf-8 -*-
class Book < ActiveRecord::Base
  has_paper_trail
  paginates_per 10
  has_many :lendings
  has_many :reservations

  has_and_belongs_to_many :collections

  after_initialize :init
  after_save :save_to_fts

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end

  def borrower
    current_lending ? current_lending.borrower.name : "nicht entliehen"
  end

  def next_reservation
    if self.reservations.count == 0
      nil
    else
      self.reservations.order(:created_at).first
    end
  end

  def self.search keys
    # TODO: Build real sql query
    ids = ActiveRecord::Base.connection.execute("select rowid from books_fts where books_fts match #{ActiveRecord::Base.connection.quote(keys)}").map{|h| h["rowid"]}
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

  def sqlize attributes
    attribute_names = Book.attribute_names.dup
    attribute_names[0] = :rowid
    "INSERT OR REPLACE INTO books_fts(#{attribute_names.join(', ')}) VALUES(#{attributes.map{|a| ActiveRecord::Base.connection.quote(a)}.join(', ')});"
  end

  def save_to_fts
    sql = sqlize self.attributes.values
    sql.gsub!("\u0000","") # For some reason, there was this invalid null-byte in the database
    ActiveRecord::Base.connection.execute sql
  end

end
