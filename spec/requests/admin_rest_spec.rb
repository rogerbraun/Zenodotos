require "spec_helper"

describe "All the rest" do

  let(:admin) {Factory(:admin_user)}

  before do
    visit new_admin_user_session_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_on "Login"
  end

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

    

end
