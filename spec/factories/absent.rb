FactoryGirl.define do
  factory :absent do
    sequence(:user_id) {|n| "#{n}"}
    reason "Because"
    date_from 1.day.ago
    date_to Time.now + 2.day
    association :user
  end

end