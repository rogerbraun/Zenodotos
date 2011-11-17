class Lending < ActiveRecord::Base
  scope :overdue, lambda { where("return_date < ? and returned != ?", Time.now, true) }
  belongs_to :borrower
  belongs_to :book
end
