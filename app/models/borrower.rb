class Borrower < ActiveRecord::Base

  has_many :lendings

  def borrow(book, date = nil)
    date ||= 1.month.from_now
    lending = Lending.new
    lending.borrower = self
    lending.book = book
    lending.return_date = date
    lending.save
  end

  def return_all_books
    lendings.unreturned.each(&:return)
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
end
