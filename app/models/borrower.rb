# -*- encoding : utf-8 -*-
class Borrower < ActiveRecord::Base
  extend Picky::Client::ActiveRecord.configure(host: 'localhost', port: PICKY_PORT, path: '/')
  has_paper_trail
  paginates_per 10

  has_many :lendings
  has_many :reservations

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
    # TODO: Find out how to tell Picky to get all ids
    res = BorrowerSearch.search(:query =>keys, :ids => 1000000)
    res.extend Picky::Convenience 
    ids = res.ids(1000000)
    Borrower.where("id in (?)", ids)
  end

end
