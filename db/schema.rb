# -*- encoding : utf-8 -*-
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111220223043) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "books", :force => true do |t|
    t.string   "titel"
    t.string   "autor"
    t.string   "hrsg"
    t.string   "signatur"
    t.integer  "jahr"
    t.text     "kommentar"
    t.text     "anmerkungen"
    t.string   "auflage"
    t.string   "baende"
    t.string   "bearbeiter"
    t.text     "bestelladresse"
    t.string   "drehbuch"
    t.string   "format"
    t.text     "inhalt"
    t.string   "sprache"
    t.string   "literaturvorlage"
    t.string   "nebensignatur"
    t.string   "ort"
    t.string   "platz"
    t.string   "preis"
    t.string   "publikationsart"
    t.string   "reihe"
    t.string   "seiten"
    t.string   "stifter"
    t.string   "verlag"
    t.string   "standort"
    t.integer  "datensatz"
    t.date     "aufnahmedatum"
    t.string   "issn"
    t.string   "isbn"
    t.string   "invent"
    t.string   "autor_japanisch"
    t.string   "hrsg_japanisch"
    t.string   "drehbuch_japanisch"
    t.string   "reihe_japanisch"
    t.string   "titel_japanisch"
    t.string   "verlag_japanisch"
    t.string   "literaturvorlage_japanisch"
    t.text     "nacsis_japanisch"
    t.integer  "jid"
    t.string   "nacsis_url"
    t.string   "interne_notizen"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "vormerken"
    t.string   "altes_datum"
  end

  create_table "borrowers", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lendings", :force => true do |t|
    t.date     "return_date"
    t.integer  "borrower_id"
    t.integer  "book_id"
    t.boolean  "returned",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "printout_id"
  end

  add_index "lendings", ["book_id"], :name => "index_lendings_on_book_id"
  add_index "lendings", ["borrower_id"], :name => "index_lendings_on_borrower_id"

  create_table "printouts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
