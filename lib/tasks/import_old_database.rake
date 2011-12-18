class Hash
  def rename(oldkey, newkey)
    self[newkey] = self[oldkey]
    self.delete(oldkey)
  end
end

namespace :db do
  task :import_books=> :environment do
    DB = Sequel.connect(ENV["OLD_DB"])
    books = DB[:buch]
    puts "Warning: No Borrowers in DB." if Borrower.count == 0
    puts "Found #{books.count} books, trying to add them..."
    Book.transaction do 
      books.each do |book|

        book.rename(:ID,:id)
        book.rename(:Hrsg,:hrsg)
        book.rename(:Signatur, :signatur)
        book.rename(:Jahr, :jahr)
        book.rename(:Kommentar, :kommentar)
        book.rename(:bde, :baende)
        book.rename(:bearb, :bearbeiter)
        book.rename(:autor_sj, :autor_japanisch)
        book.rename(:Hrsg_sj, :hrsg_japanisch)
        book.rename(:titel_sj, :titel_japanisch)
        book.rename(:drehbuch_sj, :drehbuch_japanisch)
        book.rename(:reihe_sj, :reihe_japanisch)
        book.rename(:verlag_sj, :verlag_japanisch)
        book.rename(:litvor_sj, :literaturvorlage_japanisch)
        book.rename(:nacsis_sj, :nacsis_japanisch)
        book.rename(:internenotizen, :interne_notizen)
        book.rename(:Vormerken,:vormerken)

        # Komplexeres

        datum = book.delete(:datum)
        entleiher = book.delete(:entleiher) || ""
        leihende = book.delete(:leihende) || ""
        aenderungsdatum = book.delete(:aenderungsdatum)
        book.delete(:dump)
        book.delete(:mahnung)
        book.delete(:verlaengerung)

        b = Book.new(book)
        
        unless b.save
          puts b.errors
          puts b.isbn
        end
        if entleiher.strip != "" or leihende.strip != ""
          borrower = Borrower.find_by_name(entleiher.strip)
          unless borrower
            puts "Borrower not found: #{entleiher.strip }"
            puts "book: #{b.id}, #{b.titel}"
          else
            lending = Lending.new
            lending.book = b
            lending.borrower = borrower
            lending.returned = false
            begin 
              lending.return_date = DateTime.strptime(leihende, "%m/%d/%Y")
            rescue => e
              puts e
              puts leihende
              lending.return_date = 1.month.from_now
            end
            unless lending.save
              puts lending.errors
            end
          end
        end
      end
    end
    puts "Done"
  end

  task :import_users => :environment do

    DB = Sequel.connect(ENV["OLD_DB"])
    users = DB[:ausleihers]
    puts "Found #{users.count} users, trying to add them..."
    Borrower.transaction do
      users.each do |user|
        user.each do |k, v|
          v.gsub!("\v","\n") if v.class == String
        end
        user.delete(:email2)
        user[:updated_at] = user[:aenderungsdatum]
        user.delete(:aenderungsdatum)
        user.delete(:fachkombi)
        Borrower.create(user)
      end
    end
    puts "Done"
  end

end
