FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { BCrypt::Password.create('*%NkOnJsH4') }
    password_confirmation { password }
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
