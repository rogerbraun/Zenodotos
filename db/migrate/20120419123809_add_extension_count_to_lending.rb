class AddExtensionCountToLending < ActiveRecord::Migration
  def change
    add_column :lendings, :extCount, :integer, :default => 0
  end
end
