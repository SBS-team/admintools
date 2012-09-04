FactoryGirl.define do
  factory :event do
    starts_at 1.day.ago
    ends_at Time.now
  end
end
