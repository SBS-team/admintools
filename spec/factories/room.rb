FactoryGirl.define do
  factory :room do
    sequence(:name) {|n| "name#{n}"}
    sequence(:user_id) {|n| "#{n}"}
  end
end