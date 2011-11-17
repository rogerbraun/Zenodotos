class Book < ActiveRecord::Base
  has_many :lendings

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end
  
end
