#encoding: utf-8

namespace :db do 
  task :import_rest_kyoto_data=> :environment do
    tab_file = open(ENV["KYOTO_DATA"]).readlines.map{|line| line.gsub("\r\n", "").split("\t")}
    field_titles = [:anmerkungen, :auflage, :autor, :autor_japanisch, :baende, :bearbeiter, :altes_datum, :entleiher, :format, :inhalt, :invent, :jahr, :leihende, :nebensignatur, :ort, :preis, :publikationsart, :reihe, :reihe_japanisch, :seiten, :signatur, :sprache, :stifter,:titel, :titel_japanisch, :verlag, :verlag_japanisch,:weitere_autoren_hrsg, :weitere_autoren_hrsg_japanisch, :standort, :isbn, :nacsis_japanisch, :nacsis_aufnahmedatum, :issn, :nacsis_url, :handapparat, :mahnung, :verlaengerung]
    Book.transaction do
      tab_file.each do |line|
        book = Hash.new
        #delete unnecessary columns
        line.delete_at(6)
        line.delete_at(7)
        line.delete_at(7)
        line.delete_at(13)
        line.delete_at(13)
        line.delete_at(15)
        line.delete_at(32)
        line.delete_at(32)
        line.delete_at(35)
        line.delete_at(35)
        0.upto(line.length - 1) do |num|
          next if line[num] == ""
          book[field_titles[num]] = line[num]
        end

        #merge autor, weitere autoren
        if book[:weitere_autoren_hrsg]
          book[:autor]? book[:autor] += "; " + book[:weitere_autoren_hrsg] : book[:autor] = book[:weitere_autoren_hrsg]
          book.delete(:weitere_autoren_hrsg)
        end
        #merge autor/hrsg, weitere.. japanisch
        if book[:weitere_autoren_hrsg_japanisch]
          book[:autor_japanisch] ? book[:autor_japanisch] += "; " + book[:weitere_autoren_hrsg_japanisch] : book[:autor_japanisch] = book[:weitere_autoren_hrsg_japanisch]
          book.delete(:weitere_autoren_hrsg_japanisch);
        end


        #delete not using fields
        book.delete(:nacsis_aufnahmedatum)
        book.delete(:entleiher)
        book.delete(:handapparat)
        book.delete(:verlaengerung)
        book.delete(:leihende)
        book.delete(:mahnung)
        puts book

        b = Book.new(book)

        #convert Date
        begin
          b.aufnahmedatum = DateTime.strptime(b.altes_datum, "%m/%d/%Y")
        rescue
        end

        unless b.save
          puts b.errors
          puts b.isbn
        end


      end

    end
  end

end

