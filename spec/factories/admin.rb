FactoryGirl.define do
  factory :admin do

    sequence(:email) {|n| "example#{n}@example.com"}
    sequence(:name) {|n| "admin#{n}"}
    password "secret"
    password_confirmation "secret"


  end

  factory :super_admin, :parent => :admin do
    name "admin"
  end

end