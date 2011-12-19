require "spec_helper"

describe Borrower do

  it "should return all borrowed books" do
    borrower = Factory(:borrower)
    book_1, book_2 = Factory(:book), Factory(:book)

    borrower.borrow(book_1)
    borrower.borrow(book_2)

    borrower.lendings.unreturned.count.should == 2

    borrower.return_all_books
    
    borrower.lendings.unreturned.count.should == 0

  end

  it "should borrow books" do
    borrower = Factory(:borrower)
    book = Factory(:book)

    borrower.lendings.count.should == 0

    borrower.borrow(book)
    
    borrower.lendings.count.should == 1
  end

  it "should send a reminder" do
    borrower = Factory(:borrower)
    book1, book2 = Factory(:book), Factory(:book)
    borrower.borrow(book1, 1.month.ago)
    borrower.borrow(book2, 1.month.ago)
    borrower.send_overdue_reminder
    mail = ActionMailer::Base.deliveries.last
    mail.body.to_s.should include(book1.titel)
    mail.body.to_s.should include(book2.titel)
  end

end
