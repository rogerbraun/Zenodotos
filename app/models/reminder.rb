class Reminder < ActiveRecord::Base
  has_and_belongs_to_many :lendings

  def self.from_overdue
    self.new(lendings: Lending.overdue)
  end

  def deliver
    @mails = ReminderDecorator.new(self).lendings_by_borrower.map{|borrower, lendings| BorrowerMailer.overdue_reminder(borrower, lendings)}
    @mails.each do |mail|
      begin 
        mail.deliver
      rescue

      end
    end
    self.update_attributes(send_date: Date.today)
  end

end
