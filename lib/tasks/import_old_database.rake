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

        # Komplexeres

        datum = book.delete(:datum)
        entleiher = book.delete(:entleiher)
        leihende = book.delete(:leihende)
        aenderungsdatum = book.delete(:aenderungsdatum)
        book.delete(:dump)
        book.delete(:Vormerken)
        book.delete(:mahnung)
        book.delete(:verlaengerung)

        b = Book.new(book)
        
        unless b.save
          puts b.errors
          puts b.isbn
        end
      end
    end
  end

  task :import_users => :environment do

    DB = Sequel.connect(ENV["OLD_DB"])
    users = DB[:ausleihers]
    users.each do |user|
      user.delete(:email2)
      user[:updated_at] = user[:aenderungsdatum]
      user.delete(:aenderungsdatum)
      user.delete(:fachkombi)
      Borrower.create(user)
    end
  end
end
