FactoryGirl.define do
  factory :user do
    sequence(:first_name){ "Vasya" }
    sequence(:last_name){ "Ivanov" }
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:skype) { |n| "fooskype#{n}" }
    sequence(:phone) {"+380 #{(1..9).map{SecureRandom.random_number(n=9)}.join("")}"}
    sequence(:info) { |n| "info#{n}" }
  end

  factory :invalid_user, :parent => :user do
    email ""
  end
end