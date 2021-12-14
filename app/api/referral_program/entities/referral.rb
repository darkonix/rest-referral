module ReferralProgram
	module Entities
		class Referral < Grape::Entity
			expose :id
			expose :code
			expose :signups
		end
	end
end