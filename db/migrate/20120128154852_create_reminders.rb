class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.date :send_date

      t.timestamps
    end
  end
end
