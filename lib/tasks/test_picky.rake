namespace :db do
  task :picky_full_index=> :environment do
    Book.find_each do |book|
      book.save
    end
    Borrower.find_each do |borrower|
      borrower.save
    end
  end
end
