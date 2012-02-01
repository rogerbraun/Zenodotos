# -*- encoding : utf-8 -*-
#encoding: utf-8

class BorrowerMailer < ActionMailer::Base
  default from: "bibliothek@japanologie.uni-tuebingen.de"

  def overdue_reminder(borrower, lendings)
    @name = borrower.name
    @lendings = lendings
    mail :to => borrower.email, :cc => "bibliothek@japanologie.uni-tuebingen.de", :subject => "Bücher sind überfallig" 
  end
end
