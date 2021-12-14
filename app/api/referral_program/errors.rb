module ReferralProgram
	module Errors
		extend ActiveSupport::Concern

		included do
			rescue_from Grape::Exceptions::ValidationErrors do |e|
				error!({ messages: e.full_messages }, 400)
			end

			rescue_from ActiveRecord::RecordNotFound do |e|
				error!({ messages: ['Record Not Found'] }, 404)
			end

			rescue_from :all do |e|
				error!({ messages: [e.message] }, 500)
			end
		end
	end
end