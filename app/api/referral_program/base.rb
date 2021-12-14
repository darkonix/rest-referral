require 'grape-swagger'
require 'grape-swagger-entity'

module ReferralProgram
	class Base < Grape::API
		include ReferralProgram::Errors

		format :json
		prefix :api
		version 'v1', :path

		mount ReferralProgram::V1::Users

		add_swagger_documentation \
			info: {
				title: "Referral Program",
				description: "A Referral Program API for shareable referral links",
				contact_name: "Mycke Ramos",
				contact_email: "mycke.ram@gmail.com",
			},
			tags: [
				{ name: 'Users', description: 'Operations regarding users' },
				{ name: 'Referrals', description: 'Operations regarding the referrals of an user' },
			]
	end
end