class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
    end

    create_table :books_collections do |t|
      t.integer :book_id
      t.integer :collection_id
    end
  end
end
