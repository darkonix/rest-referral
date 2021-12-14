FactoryBot.define do
  factory :referral do
    user { nil }
    code { "MyString" }
    signups { 1 }
  end
end
