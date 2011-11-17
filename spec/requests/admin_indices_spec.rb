require 'spec_helper'
require "pry"

describe "Admin index page" do

  describe "When user is an admin" do

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
    end

    describe "overdue book index" do
      it "should display all overdue books" do
        lending = Factory(:overdue_lending)
        
        visit admin_lendings_path
        click_on "Overdue"
        page.should have_content(lending.borrower.name)
        page.should have_content(lending.book.titel)
      end
    end
  end
end
