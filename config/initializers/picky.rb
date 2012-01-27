# Build initial index
# Book.reindex
#
if Book.table_exists? then 
  BookIndex = Picky::Index.new :books do
    source Book.all
    #backend Picky::Backends::SQLite.new{realtime:true}

    Book.attribute_names[1..-1].each do |cname|
      category cname.to_sym
    end

    category(:entleiher, from: :borrower)

    indexing  removes_characters: /[^\p{Han}\p{Hiragana}\p{Katakana}a-zA-Z0-9\. ]/u,
              substitutes_characters_with: Picky::CharacterSubstituters::WestEuropean.new,
              splits_text_on: /\s/u
  end

  BookSearch = Picky::Search.new BookIndex do
    searching removes_characters: /[^\p{Han}\p{Hiragana}\p{Katakana}a-zA-Z0-9\.: ]/u,
              substitutes_characters_with: Picky::CharacterSubstituters::WestEuropean.new,
              splits_text_on: /\s/u

  end

  begin
    raise "testing" if Rails.env == "test"
    BookIndex.load 
  rescue
    BookIndex.index # Index on first boot
  end
  at_exit { BookIndex.dump } unless Rails.env == "test"
end
