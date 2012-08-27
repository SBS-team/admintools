FactoryGirl.define do
  factory :room do
    sequence(:name){|n| n}
    sequence(:user_id){|n| n}
  end
end