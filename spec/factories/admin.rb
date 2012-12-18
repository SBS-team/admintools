FactoryGirl.define do

  factory :admin do
    sequence(:email) {|n| "example#{n}@example.com"}
    sequence(:name) {|n| "admin#{n}"}
    password "secret"
    password_confirmation { password }
  end

  factory :super_admin, :parent => :admin do
    name "admin"
    email "admin@admin.com"
  end


end