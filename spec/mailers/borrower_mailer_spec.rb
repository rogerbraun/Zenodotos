# -*- encoding : utf-8 -*-
require "spec_helper"

describe BorrowerMailer do
  it "should send mails to users with overdue books" do
    lending = Factory(:overdue_lending)

    described_class.overdue_reminder(lending.borrower).deliver
    mail = ActionMailer::Base.deliveries.last
    mail.to.first.should == lending.borrower.email
    mail.body.should match(lending.book.titel)
  end
end
