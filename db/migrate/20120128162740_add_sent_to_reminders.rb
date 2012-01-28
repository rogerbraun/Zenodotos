class AddSentToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :sent, :boolean

  end
end
