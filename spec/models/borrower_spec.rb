require "spec_helper"

describe Borrower do

  it "should be possible to return all borrowed books" do
    borrower = Factory(:borrower)
    book_1, book_2 = Factory(:book), Factory(:book)

    borrower.borrow(book_1)
    borrower.borrow(book_2)

    borrower.lendings.unreturned.count.should == 2

    borrower.return_all_books
    
    borrower.lendings.unreturned.count.should == 0

  end

  it "should be possible to borrow books" do
    borrower = Factory(:borrower)
    book = Factory(:book)

    borrower.lendings.count.should == 0

    borrower.borrow(book)
    
    borrower.lendings.count.should == 1
  end

end
