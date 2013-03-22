#encoding:utf-8
namespace :db do

  desc 'Fill the full text search shadow table'
  task :fill_fts_table => :environment do
    puts "Indexing Books..."
    Book.find_in_batches do |books|
      Book.transaction do
        print "."
        books.each do |book|
          book.run_callbacks(:save)
        end
      end
    end

    puts "Indexing Borrowers..."
    Borrower.find_in_batches do |borrowers|
      Borrower.transaction do
        print "."
        borrowers.each do |borrower|
          borrower.run_callbacks(:save)
        end
      end
    end
  end
end
