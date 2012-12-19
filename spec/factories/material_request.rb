FactoryGirl.define do
  factory :material_request do
    sequence(:name) {|n| "#{n}"}
    priority 0
    status false
    association :user
  end
end