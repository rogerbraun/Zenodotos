require 'spec_helper'
require "pry"

describe "Admin page" do

  let(:admin) {Factory(:admin_user)}

  before do
    10.times do
      Factory(:book)
      Factory(:lending)
    end

    visit new_admin_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Login"
  end

  describe "book index" do
    it "should display the books in the database" do 
      visit admin_books_path
      page.should have_content(Book.first.titel)
    end
  end

  describe "lending index" do
    it "should display the lendings" do
      visit admin_lendings_path
      page.should have_content(Lending.first.book.titel)
    end

    it "should have a way to send overdue reminders to all users" do
      ActionMailer::Base.deliveries = []

      10.times do 
        Factory(:overdue_lending)
      end

      visit admin_lendings_path    
      click_on "send_overdue_reminders"
      ActionMailer::Base.deliveries.last.should_not be_nil
      page.should have_content("gemahnt")
    end

    it "should display all overdue books" do
      lending = Factory(:overdue_lending)
      
      visit admin_lendings_path
      click_on "Overdue"
      page.should have_content(lending.borrower.name)
      page.should have_content(lending.book.titel)
    end
  end

  describe "Borrowing and returning" do

    describe "Borrowing a book" do
      it "should be lendable from the book page" do
        book = Factory(:book)
        borrower = Factory(:borrower)

        visit admin_book_path(book)
        select(borrower.name, from: "Borrower")
        click_on "Verleihen"

        page.should have_content("wurde verliehen")

        book.current_lending.should_not be_nil

      end
    end
  end
end
