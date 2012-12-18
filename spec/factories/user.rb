FactoryGirl.define do
  factory :user do
    first_name "Vasya"
    last_name "Ivanov"
    sequence(:email) { |n| "foo#{n}@example.com" }
    sequence(:skype) { |n| "fooskype#{n}" }
    sequence(:phone) {"+380 #{(1..9).map{SecureRandom.random_number(n=9)}.join("")}"}
    sequence(:info) { |n| "info#{n}" }
    password "example"
    password_confirmation { password }
    role "user"
  end

  factory :invalid_user, :parent => :user do
    email ""
  end

  factory :manager, :parent => :user do
    role 'manager'
  end

  factory :teamleader, :parent => :user do
    role 'teamleader'
    department
  end
end