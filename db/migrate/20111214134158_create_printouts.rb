# -*- encoding : utf-8 -*-
class CreatePrintouts < ActiveRecord::Migration
  def change
    create_table :printouts do |t|

      t.timestamps
    end
  end
end
