FactoryGirl.define do
  factory :user do
    first_name "Vasya"
    last_name "Ivanov"
    sequence(:email) {|n| "example#{n}@example.com"}
    skype "example"
  end
end