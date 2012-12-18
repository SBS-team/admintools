FactoryGirl.define do
  factory :department do
    sequence(:name) {|n| "name#{n}"}
  end
end