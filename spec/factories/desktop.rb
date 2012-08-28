FactoryGirl.define do
  factory :desktop do
    ip (1..4).map{SecureRandom.random_number(n=192)}.join(".")
    mac (1..6).map{SecureRandom.hex(1)}.join(":")
    sequence(:user_id) {|n| "#{n}"}
    name "Ivanov"
  end

end