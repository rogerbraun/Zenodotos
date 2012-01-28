class Reminder < ActiveRecord::Base
  has_and_belongs_to_many :lendings

  def self.from_overdue
    self.new(lendings: Lending.overdue)
  end
end
