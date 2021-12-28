require 'grape-swagger'
require 'grape-swagger-entity'

module ReferralProgram
	class Base < Grape::API
		include ReferralProgram::Errors

		format :json
		prefix :api
		version 'v1', :path

		helpers do
			def verify(token)
				JWT.decode(token, nil,
					true, # Verify the signature of this token
					algorithms: 'RS256',
					iss: Rails.application.credentials.auth0[:issuer], #'https://dev-erj9-6fy.us.auth0.com/'
					verify_iss: true,
					aud: Rails.application.credentials.auth0[:beholder], #'https://secure-falls-61384.herokuapp.com'
					verify_aud: true
				) do |header|
						jwks_hash[header['kid']]
					end
			end

			def jwks_hash
				jwks_raw = Net::HTTP.get URI(Rails.application.credentials.auth0[:issuer] + ".well-known/jwks.json")
				jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
				Hash[
					jwks_keys
					.map do |k|
					[
						k['kid'],
						OpenSSL::X509::Certificate.new(
							Base64.decode64(k['x5c'].first)
						).public_key
					]
					end
				]
			end

			def authenticate_request!
				verify(http_token)
			end

			def http_token
				if request.headers['Authorization'].present?
					request.headers['Authorization'].split(' ').last
				end
			end
		end

		before do
			authenticate_request!
		end

		mount ReferralProgram::V1::Users

		add_swagger_documentation \
			info: {
				title: "Referral Program",
				description: "A Referral Program API for shareable referral links",
				contact_name: "Mycke Ramos",
				contact_email: "mycke.ram@gmail.com",
			},
			models: [
				ReferralProgram::Entities::User,
				ReferralProgram::Entities::Referral
			],
			tags: [
				{ name: 'Users', description: 'Operations regarding users' },
				{ name: 'Referrals', description: 'Operations regarding the referrals of an user' },
			]
	end
end