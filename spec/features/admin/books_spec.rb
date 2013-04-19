require 'spec_helper'
require_relative "admin_helper"

describe Admin do
  describe Book do

    let!(:borrower) { FactoryGirl.create :borrower }
    let(:book) { FactoryGirl.create :book }
    let(:borrowed_book) { FactoryGirl.create :book }
    let!(:lending) { FactoryGirl.create :lending, book: borrowed_book }

    before(:each) do
      login_as_admin
      10.times do
        Factory(:book)
        Factory(:lending)
      end
    end

    describe "Index Page" do
      before(:each) do
        visit admin_books_path
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
        fill_in "book_titel", with: "Onko der harmonische"
        click_on "submit_book"
        Book.where("titel = ?", "Onko der harmonische").count.should == 1
      end

      it "has a working search" do
        Factory(:book, :titel => "Mein liebstes Buch")
        fill_in "search", with: "Mein liebstes Buch"
        click_on "search_button"
        page.should have_content("Mein liebstes Buch")
      end

      it "can extend the return date of a book" do
        @overdue = Factory(:overdue_lending)
        @book = @overdue.book
        fill_in "search", with: @book.titel
        click_on "search_button"
        page.find("#extend_book_#{@book.id}").click
        @book.lendings.overdue.should be_empty
      end

      it "can return a book" do
        @lending = Factory(:lending)
        @book = @lending.book
        fill_in "search", with: @book.titel
        click_on "search_button"
        page.find("#return_book_#{@book.id}").click
        @book.current_lending.should be_nil
      end

      it "can lend a book", :js => true do
        @book = Factory(:book, :titel => "Mein liebstes Buch")  
        @book.current_lending.should be_false
        fill_in "search", with: "Mein liebstes Buch"
        click_on "search_button"
        page.find("#lend_book_#{@book.id}").click
        page.should have_content("Buch verleihen")
        page.click_on "lend_book_button"
        @book.current_lending.should be_true
      end

      it "can make a reservation of a book", :js => true do
        # Search for our book
        fill_in "search", with: borrowed_book.titel
        click_on "search_button"

        # Click the reservation link
        click_on "reserve_book_#{borrowed_book.id}"

        # We should get the modal window
        page.should have_content('Buch vormerken')

        # Select a borrower and submit the form
        select borrower.name
        click_on 'reserve_book_button'

        # We should have a reservation now
        borrowed_book.reload
        expect(borrowed_book.reservations.count).to be 1
      end

      it "can destroy a book", :js => false do
        @book = Factory(:book, :titel => 'Unique Book')
        fill_in "search", with: "Unique Book"
        click_on "search_button"
        id = @book.id
        page.find("#delete_book_#{id}").click
        #page.driver.wait_until(page.driver.browser.switch_to.alert.accept)
        #page.driver.browser.switch_to.alert.accept
        expect{Book.find(id)}.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should show a book's information and link to print" do
        @book = Factory(:book, :titel => 'A good book')
        fill_in "search", with: "titel:#{@book.titel}"
        click_on "search_button"
        page.find("a#book_#{@book.id}").click
        page.find("a#book_#{@book.id}").click
        page.should have_content "Buch ##{@book.id}"
        page.should have_link("Diese Seite drucken")
      end

    end

    describe "Member Page" do
      before do
        @book = Book.first
        visit edit_admin_book_path(@book)
      end

      it "displays a single book", :js => false do
        page.should have_content @book.titel
      end

      it "can update a book" do
        fill_in "book_titel", with: "Ein neuer Titel"
        click_on "submit_book"
        @book.reload
        @book.titel.should == "Ein neuer Titel"
      end
    end
  end
end
