class Lending < ActiveRecord::Base
  scope :overdue, lambda { where("return_date < ? and returned != ?", Time.now, true) }
  scope :unreturned, where("returned != ?", true)
  belongs_to :borrower
  belongs_to :book
  belongs_to :printout

  validates_presence_of :borrower, :book, :return_date
  
  #validates_uniqueness_of :book_id, :scope => :returned

  def return
    update_attribute(:returned, true)
  end
end
