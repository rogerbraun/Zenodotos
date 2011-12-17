class AddVormerkenToBook < ActiveRecord::Migration
  def change
    add_column :books, :vormerken, :text
  end
end
