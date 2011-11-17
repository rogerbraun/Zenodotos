FactoryGirl.define do

  factory :admin_user do
    sequence(:email){|n| "user_#{n}@example.com"}
    password "anything"
    password_confirmation "anything"
  end

  factory :book do
    sequence(:titel){|n| "Titel #{n}"}
  end

  factory :borrower do
    sequence(:email){|n| "borrower_#{n}@example.com"}
    sequence(:name) {|n| "Borrower Number #{n}"} 
  end

  factory :lending do
    return_date 1.month.from_now
    association :borrower
    association :book
    returned false
  end

  factory :overdue_lending, parent: :lending do
    return_date 1.month.ago
  end
end
