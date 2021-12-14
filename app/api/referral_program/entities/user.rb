module ReferralProgram
    module Entities
        class User < Grape::Entity
            expose :name
            expose :email
            expose :referrals, using: ReferralProgram::Entities::Referral
        end
    end
end