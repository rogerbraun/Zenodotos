require "spec_helper"

describe Lending do

  it "should not allow two lendings for the same book" do
    user = Factory(:borrower)
    book = Factory(:book)
    date = 1.month.from_now
    
    lending = Lending.new
    lending.borrower = user
    lending.book = book
    lending.return_date = date
    lending.save

    lending.id.should_not be_nil


    lending = Lending.new
    lending.borrower = user
    lending.book = book
    lending.return_date = date
    lending.save

    lending.id.should be_nil

  end

  it "should return books" do
    lending = Factory(:lending)
    lending.returned.should be_false
    lending.return
    lending.reload
    lending.returned.should be_true
  end
end
