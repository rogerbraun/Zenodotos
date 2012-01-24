# -*- encoding : utf-8 -*-
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
    lending.valid?.should be_false

  end

  it "should allow new lendings after books have been returned" do
    user = Factory(:borrower)
    book = Factory(:book)
    date = 1.month.from_now
    
    lending = Lending.new(:borrower => user, :book => book, :return_date => date)
    lending.save.should be_true

    lending.return

    lending = Lending.new(:borrower => user, :book => book, :return_date => date)
    lending.save.should be_true
  end

  it "should return books" do
    lending = Factory(:lending)
    user, book = lending.borrower, lending.book
    lending.returned.should be_false
    lending.return

    lending.reload
    lending.returned.should be_true

    l2 = Lending.new(:book => book, :borrower => user, :return_date => 1.month.ago)
    l2.save.should be_true
    l2.return

    l2.returned.should be_true

  end

  it "allows extending the return date by a standard amount of days" do
    lending = Factory(:lending)
    date = lending.return_date.dup
    date = date + 28.days
    lending.extend_date
    lending.return_date.should == date
  end

  it "allows extenden the return date by a given amout of days" do
    lending = Factory(:lending)
    date = lending.return_date.dup
    date = date + 40.days
    lending.extend_date(40.days)
    lending.return_date.should == date
  end
end
