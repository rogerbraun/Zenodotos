module FTSSearchable
  extend ActiveSupport::Concern

  included do
    after_save :save_to_fts
  end

  module ClassMethods
    def search keys
      # TODO: Build real sql query
      table_name = self.to_s.pluralize.downcase + "_fts"
      ids = ActiveRecord::Base.connection.execute("select rowid from #{table_name} where #{table_name} match #{ActiveRecord::Base.connection.quote(keys)}").map{|h| h["rowid"]}
      where("id in (?)", ids)
    end
  end

  def sqlize attributes
    table_name = self.class.to_s.pluralize.downcase + "_fts"
    attribute_names = self.attribute_names.dup
    attribute_names[0] = :rowid
    "INSERT OR REPLACE INTO #{table_name}(#{attribute_names.join(', ')}) VALUES(#{attributes.map{|a| ActiveRecord::Base.connection.quote(a)}.join(', ')});"
  end

  def save_to_fts
    sql = sqlize self.attributes.values
    sql.gsub!("\u0000","") # For some reason, there was this invalid null-byte in the database
    ActiveRecord::Base.connection.execute sql
  end

end
