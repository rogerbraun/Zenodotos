require 'spec_helper'

describe Reminder do
  it "is created from all current overdue lendings" do
    10.times do Factory(:lending) end
    14.times do Factory(:overdue_lending) end
    
    reminder = Reminder.from_overdue
    reminder.valid?.should be_true
    reminder.lendings.size.should == 14
  end
end
