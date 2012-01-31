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

    it "displays all books if nothing is searched" do
      visit admin_books_path
      Book.limit(10).each do |book|
        page.should have_content(book.titel)
      end
    end
  end
end
