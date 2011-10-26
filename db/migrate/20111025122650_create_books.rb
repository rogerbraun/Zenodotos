class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string   "titel"
      t.string   "autor"
      t.string   "hrsg"
      t.string   "signatur"
      t.integer  "jahr"
      t.text     "kommentar" # organisatorische kommentare
      t.text     "anmerkungen" #öffentlich
      t.string   "auflage"
      t.string   "baende"
      t.string   "bearbeiter"
      t.text     "bestelladresse"
      t.string   "drehbuch" #kw
      t.string   "format"
      t.text     "inhalt"
      t.string   "sprache"
      t.string   "literaturvorlage" #kw
      t.string   "nebensignatur"
      t.string   "ort"
      t.string   "platz" #kw
      t.string   "preis"
      t.string   "publikationsart"
      t.string   "reihe"
      t.string   "seiten"
      t.string   "stifter"
      t.string   "verlag"
      t.string   "standort"
      t.integer  "datensatz"
      t.date     "aufnahmedatum" # in nacsis
      t.string   "issn"
      t.string   "isbn"
      t.string   "invent"
      t.string   "autor_japanisch"
      t.string   "hrsg_japanisch"
      t.string   "drehbuch_japanisch" #
      t.string   "reihe_japanisch"
      t.string   "titel_japanisch"
      t.string   "verlag_japanisch"
      t.string   "literaturvorlage_japanisch"
      t.text     "nacsis_japanisch"
      t.integer  "jid"
      t.string   "nacsis_url"
      t.string   "interne_notizen" #vielleicht kommentare
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
