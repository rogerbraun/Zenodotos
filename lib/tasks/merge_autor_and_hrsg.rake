namespace :db do

  desc "Merge autor/hrsg and autor_japanisch/hrsg_japanisch"
  task :merge_autor_and_hrsg => :environment do
    Book.all.each do |book|
      if book.hrsg.strip == ""
        autor = book.autor
      else
        autor = [book.autor, book.hrsg.strip].join("; ")
      end

      if book.hrsg_japanisch.strip == ""
        autor_japanisch = book.autor_japanisch
      else
        autor_japanisch = [book.autor_japanisch, book.hrsg_japanisch.strip].join("; ")
      end

      book.update_attributes autor: autor, autor_japanisch:autor_japanisch
    end
  end
end
