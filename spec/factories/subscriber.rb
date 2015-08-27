FactoryGirl.define do
  factory :subscriber do
    sequence(:email){|n| "user#{n}@test.com" }
  end
end