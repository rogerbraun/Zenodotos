class Collection < ActiveRecord::Base
  has_and_belongs_to_many :books, :uniq => true
end
