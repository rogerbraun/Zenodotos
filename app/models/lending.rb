class Lending < ActiveRecord::Base
  has_paper_trail
  scope :overdue, lambda { where("return_date < ? and returned != ?", Time.now, true) }
  scope :unreturned, where("returned != ?", true)
  belongs_to :borrower
  belongs_to :book
  belongs_to :printout

  validates_presence_of :borrower, :book, :return_date
  
  #validates_uniqueness_of :book_id, :scope => :returned
  class CurrentLendingValidator < ActiveModel::Validator
    def validate record      
      if record.new_record? and record.book.current_lending then
        record.errors[:base] << "Book is already lent!"
      end
    end
  end

  validates_with CurrentLendingValidator


  def return
    update_attribute(:returned, true)
  end

  def extend_date(days = 28.days)
    update_attribute(:return_date, return_date + days)
  end
end
