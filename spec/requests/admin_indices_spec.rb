# -*- encoding : utf-8 -*-
#encoding: utf-8
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
    click_on "Sign in"
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

    describe "Extending the return date" do
      it "has a link for extending the return date" do
        lending = Factory(:lending)
        lending.reload
        date = lending.return_date.dup
        visit admin_book_path(lending.book)
        click_on "extend_return_date"
        page.should have_content("wurde verlängert")
        lending.reload
        lending.return_date.should == date + 28.days
      end
    end

    describe "Returning a book" do
      it "should be returnable if borrowed" do
        lending = Factory(:lending)

        visit admin_book_path(lending.book)
        click_on "return_book"

        page.should have_content("wurde zurückgegeben")
        lending.book.current_lending.should be_nil
      end

      it "should be returnable from the borrower view" do
        lending = Factory(:lending)
        visit admin_borrower_path(lending.borrower)
        click_on "return_all_books"

        page.should have_content("Bücher wurden zurückgegeben")
      end
    end
  end
end
