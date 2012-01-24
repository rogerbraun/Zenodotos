# Build initial index
# Book.reindex
#

BookIndex = Picky::Index.new :books do
#  source Book.all
  Book.attribute_names[1..-1].each do |cname|
    category cname.to_sym
  end
end

Book.reindex

BookSearch = Picky::Search.new BookIndex


