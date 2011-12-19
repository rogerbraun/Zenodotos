class AddAltesDatumToBook < ActiveRecord::Migration
  def change
    add_column :books, :altes_datum, :string
  end
end
