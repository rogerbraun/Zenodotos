require 'spec_helper'
require_relative "admin_helper"

describe Admin do
  describe Book do
    before do
      login_as_admin

      10.times do
        Factory(:book)
        Factory(:lending)
      end
    end

    describe "Index Page" do
      before do
        visit admin_book_path
      end

      it "displays all books if nothing is searched" do
        Book.limit(10).each do |book|
          page.should have_content(book.titel)
        end
      end

      it "can make new books" do
        page.should have_selector("#new_book_button")  
        click_on "new_book_button"
        page.should have_content("Neues Buch")
      end

      it "has a working search" do
        Factory(:book, :titel => "Mein liebstes Buch")
        fill_in "search", with: "Mein liebstes Buch"
        click_on "search_button"
        page.should have_content("Mein liebstes Buch")
      end

      it "can lend a book", :js => true do
        @book = Factory(:book, :titel => "Mein liebstes Buch")  
        fill_in "search", with: "Mein liebstes Buch"
        click_on "search_button"
        page.find("#lend_book_#{@book.id}").click
        page.should have_content("Buch verleihen")
      end

    end

    describe "Member Page" do
      before do
        @book = Book.first
        visit admin_book_path(@book)
      end
        
      it "displays a single book" do
        page.should have_selector("input[value='#{@book.titel}']")
      end
    end
  end
end
