FactoryGirl.define do
  factory :desktop do
    sequence(:ip) {(1..4).map{SecureRandom.random_number(n=192)}.join(".")}
    sequence(:mac){(1..6).map{SecureRandom.hex(1)}.join(":")}
    sequence(:user_id) {|n| "#{n}"}
    name "Ivanov"
    association :room
  end

end