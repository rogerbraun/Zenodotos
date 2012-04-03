class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :book_id
      t.integer :borrower_id

      t.timestamps
    end
  end
end
