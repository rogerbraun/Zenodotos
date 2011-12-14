require 'spec_helper'

describe Printout do

  it "should create a Printout for all unprinted Lendings" do
    Lending.destroy_all
    1.upto(10) do Factory(:lending) end
    res = Printout.new_from_unprinted
    res.lendings.size.should == 10
  end

  it "should create a PDF from a Printout" do
    Lending.destroy_all
    1.upto(10) do Factory(:lending) end
    res = Printout.new_from_unprinted
    res.pdf_url.should_not be_nil
  end
end
