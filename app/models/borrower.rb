class Borrower < ActiveRecord::Base
  def borrow(book, date = nil)
    date ||= 1.month.from_now
    lending = Lending.new
    lending.borrower = self
    lending.book = book
    lending.return_date = date
    unless lending.save
      puts lending.errors
    end
    
  end
end
