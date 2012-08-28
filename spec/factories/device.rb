FactoryGirl.define do
  factory :device do
    ip (1..4).map{SecureRandom.random_number(n=192)}.join(".")
    mac (1..6).map{SecureRandom.hex(1)}.join(":")
    sequence(:name) {|n| "name#{n}"}
    sequence(:user_id) {|n| "#{n}"}
  end
end