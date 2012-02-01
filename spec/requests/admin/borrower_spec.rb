require 'spec_helper'
require_relative "admin_helper"

describe Admin do

  describe Borrower do
    before do
      login_as_admin

      10.times do
        Factory(:book)
        Factory(:lending)
      end
    end

    describe "index page" do
      before do
        visit admin_borrowers_path
      end

      it "displays all borrowers if nothing is searched" do
        Borrower.limit(10).each do |borrower|
          page.should have_content(borrower.name)
        end
      end

      it "has a working search" do
        @borrower = Factory(:borrower, name: "Jochen Wendecyborg")
        fill_in "search", with: @borrower.name
        click_on "search_button"
        page.should have_content(@borrower.name)
      end
    end

    describe "member page" do
      before do
        @borrower = Factory(:borrower)
        visit admin_borrower_path(@borrower)
      end

      it "can update the borrower" do
        fill_in "borrower_name", :with => "Ein neuer Name"
        click_on "submit_borrower"
        @borrower.reload
        @borrower.name.should == "Ein neuer Name"
      end
      
      it "shows all unreturned books" do
        @books = 10.times.map{Factory(:book)}
        @books.each do |book|
          @borrower.borrow(book)
        end

        visit admin_borrower_path(@borrower)
        @books.each do |book|
          page.should have_content(book.titel)
        end
      end

      it "can return a selected number of books" do
        @books = 2.times.map{Factory(:book)}
        @books.each do |book|
          @borrower.borrow book
        end

        visit admin_borrower_path(@borrower)

        @books.each do |book|
          check("lending_id_#{book.current_lending.id}")
        end

        click_on "return"

        @books.each do |book|
          book.reload
          book.current_lending.should be_nil
        end
      end

      it "can extend a selected number of books" do
        @books = 2.times.map{Factory(:book)}
        @books.each do |book|
          @borrower.borrow book, 1.day.ago
        end

        @borrower.unreturned.overdue.count.should == 2

        visit admin_borrower_path(@borrower)

        @books.each do |book|
          check("lending_id_#{book.current_lending.id}")
        end

        click_on "extend"
        
        @borrower.unreturned.overdue.count.should == 0

      end

    end

  end

end

