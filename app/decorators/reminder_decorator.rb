class ReminderDecorator < ApplicationDecorator
  decorates :reminder

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #   
  #   Or, optionally enable "lazy helpers" by calling this method:
  #     lazy_helpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #   
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"), 
  #                   :class => 'timestamp'
  #   end

  def created_at
    reminder.created_at.strftime("%d.%m.%Y")
  end

  def send_date
    return "noch nie" unless reminder
    if reminder.send_date
      reminder.send_date.strftime("%d.%m.%Y")
    else
      "Noch nicht versandt."
    end
  end

  def sent?
    !!reminder.send_date
  end

  def lendings_by_borrower
    reminder.lendings.group_by(&:borrower).sort_by{|borrower, lendings| borrower.name}
  end

  def total_emails
    lendings_by_borrower.size
  end
end
