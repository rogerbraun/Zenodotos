# Build initial index
# Book.reindex
#

BookIndex = Picky::Index.new :books do
  source Book.all
  backend Picky::Backends::SQLite.new{realtime:true}

  Book.attribute_names[1..-1].each do |cname|
    category cname.to_sym
  end
  indexing  removes_characters: /[^\p{Han}\p{Hiragana}\p{Katakana}a-zA-Z0-9\. ]/u,
            substitutes_characters_with: Picky::CharacterSubstituters::WestEuropean.new,
            splits_text_on: /\s/u
end

BookSearch = Picky::Search.new BookIndex do
  searching removes_characters: /[^\p{Han}\p{Hiragana}\p{Katakana}a-zA-Z0-9\.: ]/u,
            substitutes_characters_with: Picky::CharacterSubstituters::WestEuropean.new,
            splits_text_on: /\s/u

end

BookIndex.load
