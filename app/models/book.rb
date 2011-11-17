class Book < ActiveRecord::Base
  has_many :lendings
end
