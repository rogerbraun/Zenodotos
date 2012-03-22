PICKY_PORT = case ENV['RAILS_ENV']
       when 'development'
         '9292'
       when 'production'
         '9293'
       when 'staging'
         '9294'
       else
         '9295'
       end
puts "Picky port is #{PICKY_PORT}"

BookSearch = Picky::Client.new :host => 'localhost', :port => PICKY_PORT, :path => '/books'
BorrowerSearch = Picky::Client.new :host => 'localhost', :port => PICKY_PORT, :path => '/borrowers'
