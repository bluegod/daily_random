FactoryGirl.define do
  factory :subscriber do
    sequence(:email){|n| "user#{n}@test.com" }
    sequence(:token){|n| "token-{n}" }
  end
end