# -*- encoding : utf-8 -*-
class Borrower < ActiveRecord::Base
  has_paper_trail
  paginates_per 10

  has_many :lendings
  has_many :reservations

  after_save :save_to_fts

  def borrow(book, date = nil)
    date ||= 28.days.from_now
    lending = Lending.new
    lending.borrower = self
    lending.book = book
    lending.return_date = date
    lending.save
  end

  def remove_reservations(book)
    self.reservations.where(:book_id => book.id).destroy_all
  end

  def return_all_books
    lendings.unreturned.each(&:return)
  end

  def unreturned
    lendings.unreturned
  end

  def send_overdue_reminder
    return nil if lendings.overdue.count == 0
    BorrowerMailer.overdue_reminder(self).deliver
  end

  def self.send_overdue_reminders
    self.all.each do |borrower|
      borrower.send_overdue_reminder
    end
  end

  def borrower
    current_lending ? current_lending.borrower.name : "nicht entliehen"
  end

  def self.search keys
    # TODO: Build real sql query
    ids = ActiveRecord::Base.connection.execute("select rowid from borrowers_fts where borrowers_fts match #{ActiveRecord::Base.connection.quote(keys)}").map{|h| h["rowid"]}
    Borrower.where("id in (?)", ids)
  end

  private

  def sqlize attributes
    attribute_names = Borrower.attribute_names.dup
    attribute_names[0] = :rowid
    "INSERT OR REPLACE INTO borrowers_fts(#{attribute_names.join(', ')}) VALUES(#{attributes.map{|a| ActiveRecord::Base.connection.quote(a)}.join(', ')});"
  end

  def save_to_fts
    sql = sqlize self.attributes.values
    sql.gsub!("\u0000","") # For some reason, there was this invalid null-byte in the database
    ActiveRecord::Base.connection.execute sql
  end
end
