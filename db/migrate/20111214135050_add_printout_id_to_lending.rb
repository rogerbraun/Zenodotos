class AddPrintoutIdToLending < ActiveRecord::Migration
  def change
    add_column :lendings, :printout_id, :integer
  end
end
