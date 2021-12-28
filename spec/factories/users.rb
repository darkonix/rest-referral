FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { '*%NkOnJsH4' }
    password_confirmation { '*%NkOnJsH4' }
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
