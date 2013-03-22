class CreateFtSshadowTable < ActiveRecord::Migration
  def up
    sql = <<-SQL_STRING
      CREATE VIRTUAL TABLE books_fts USING fts4(#{Book.attribute_names.map{|a| a + " TEXT"}.join(", ")});
    SQL_STRING
    ActiveRecord::Base.connection.execute sql

    sql = <<-SQL_STRING
      CREATE VIRTUAL TABLE borrowers_fts USING fts4(#{Borrower.attribute_names.map{|a| a + " TEXT"}.join(", ")});
    SQL_STRING
    ActiveRecord::Base.connection.execute sql
  end

  def down
  end
end
