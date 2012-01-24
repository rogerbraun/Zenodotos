# -*- encoding : utf-8 -*-
class AddDefaultReturnedToLending < ActiveRecord::Migration
  def change
    change_column(:lendings, :returned, :boolean, :default => false)
  end
end
