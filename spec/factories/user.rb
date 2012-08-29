FactoryGirl.define do
  factory :user do

    sequence(:first_name) {|n| "first_name#{n}"}
    sequence(:last_name) {|n| "last_name#{n}"}
    sequence(:email) {|n| "foo#{n}@example.com"}
    sequence(:skype) {|n| "fooskype#{n}"}
    sequence(:phone) {|n| "+3 80 #{n}"}
    sequence(:info) {|n| "info #{n}"}

  end

  factory :invalid_user, :parent => :user do
    email ""
  end

end