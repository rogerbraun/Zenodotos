require 'spec_helper'
require_relative "admin_helper"

describe Admin do
  describe Collection do

    before do
      login_as_admin
      @collection = Collection.new name: "Meine Sammlung 1"
      @books = 10.times.map{Factory(:book)}
      @collection.books = @books
      @collection.save
    end

    describe "Member page" do
      it "can mass edit the books in the collection" do
        visit admin_collection_path(@collection)
        click_on "mass_edit_button"
        fill_in "book_verlag", with: "Semmel Verlach"
        click_on "submit_book"
        # TODO: Find out the Rspeccy way to do this.
        @books.each do |book| 
          book.reload
          book.verlag.should == "Semmel Verlach"
        end
      end

      it "should have a printversion without pagination" do
        visit admin_collection_path(@collection)
        click_on "Druckansicht"
        page.should have_link "Diese Seite drucken"
        page.should_not have_selector "#pagination"
      end
    end
  end
end

