#encoding: utf-8
require "spec_helper"

describe Book do

  it "should be able to do a one-param quicksearch" do
    Factory(:book, :titel => "Ein ungewöhnlicher Titel")
    @books = Book.quicksearch("ungewöhnlich")
    @books.size.should == 1
  end

end
