class Book < ActiveRecord::Base
  has_paper_trail
  paginates_per 10
  has_many :lendings

  after_initialize :init

  def current_lending
    Lending.find_by_book_id_and_returned(id, false)
  end

  def self.quicksearch q
    query = "%#{q}%"
    Book.where("autor like ? or autor_japanisch like ? or titel like ? or titel_japanisch like ?", query, query, query, query)
  end

  private
  
  def init
    self.signatur = "Signatur folgt."
    self.aufnahmedatum = Date.today
  end
  
end
