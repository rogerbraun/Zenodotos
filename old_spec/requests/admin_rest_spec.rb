# -*- encoding : utf-8 -*-
#encoding: utf-8
require "spec_helper"

describe "Pages for managing" do

  let(:admin) {Factory(:admin_user)}

  before do
    visit new_admin_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Login"
  end

  describe "Borrowers" do

    it "should show the borrowed books on the borrower page" do
      user = Factory(:borrower)
      book = Factory(:book)
      book2 = Factory(:book)
      user.borrow(book)
      user.borrow(book2)

      visit admin_borrower_path(user)

      page.should have_content(book.titel)
      page.should have_content(book2.titel)
    end

    it "should not show any actions if there are no unreturned books" do
      user = Factory(:borrower)
      visit admin_borrower_path(user)

      page.should_not have_selector "#return_all_books"


    end
  end

end
