class CreateLendingsReminders < ActiveRecord::Migration
  def change 
    create_table :lendings_reminders do |t|
      t.integer "lending_id"
      t.integer "reminder_id"
    end
  end
end
