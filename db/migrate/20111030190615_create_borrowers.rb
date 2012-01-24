# -*- encoding : utf-8 -*-
class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string   "anschrift"
      t.string   "bearbeiter"
      t.string   "email"
      t.string   "heimatanschrift"
      t.integer  "matrikelnr"
      t.string   "mobiltelefon"
      t.string   "name"
      t.string   "status"
      t.string   "telefon"
      t.string   "telefon2"
      t.string   "ub_nr"
      t.string   "vermerke"

      t.timestamps
    end
  end
end
