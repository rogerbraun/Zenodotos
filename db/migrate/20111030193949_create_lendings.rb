# -*- encoding : utf-8 -*-
class CreateLendings < ActiveRecord::Migration
  def change
    create_table :lendings do |t|
      t.date :return_date
      t.references :borrower
      t.references :book
      t.boolean :returned

      t.timestamps
    end
    add_index :lendings, :borrower_id
    add_index :lendings, :book_id
  end
end
