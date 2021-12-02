module ReferralProgram
	class Api < Grape::API
		format :json
		prefix :api
		version 'v1', :path

		mount ReferralProgram::V1::Users
	end
end