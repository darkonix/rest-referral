FactoryBot.define do
  factory :referral do
    user
    code { Faker::Alphanumeric.alpha(number: 24) }
    signups { Faker::Number.number(digits: 2) }
  end
end
