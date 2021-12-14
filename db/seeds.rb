# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
50.times do
	user = User.create(
		name: Faker::Name.name,
		email: Faker::Internet.email,
		password: '*%NkOnJsH4',
		password_confirmation: '*%NkOnJsH4',
		balance: Faker::Number.decimal(l_digits: 2)
	)

	if user.persisted?
		user.referrals.create()
	end
end