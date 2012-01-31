# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Printout do

  it "should create a Printout for all unprinted Lendings" do
    Lending.destroy_all
    1.upto(10) do Factory(:lending) end
    res = Printout.new_from_unprinted
    res.valid?.should be_true
    res.lendings.size.should == 10
  end

  it "should create a PDF from a Printout" do
    Lending.destroy_all
    1.upto(10) do Factory(:lending) end
    res = Printout.new_from_unprinted
    res.valid?.should be_true
    File.exists?(File.join(Rails.root, "public", res.pdf_url)).should be_true
  end
end
