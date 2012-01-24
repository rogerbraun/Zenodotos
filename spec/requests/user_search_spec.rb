# -*- encoding : utf-8 -*-
#encoding: utf-8
require "spec_helper"

describe "The interface for end users" do

  it "should display a search form" do
    visit root_path
    page.should have_selector("#search_form")
  end

  it "should return search results" do
    book = Factory(:book, titel: "Ein verrückter Titel", autor: "crazy Author")
    visit root_path
    fill_in "q", :with => "verrückt"
    click_on "search_button"
    page.should have_content("crazy") 
  end

end
