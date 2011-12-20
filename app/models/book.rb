class Book < ActiveRecord::Base
  has_paper_trail
  paginates_per 10
  has_many :lendings

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end

  def self.quicksearch q
    query = "%#{q}%"
    Book.where("autor like ? or autor_japanisch like ? or titel like ? or titel_japanisch like ?", query, query, query, query)
  end
  
end
