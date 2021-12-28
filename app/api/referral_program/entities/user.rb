module ReferralProgram
    module Entities
        class User < Grape::Entity
            expose :id
            expose :name
            expose :email
            expose :referee_id
        end
    end
end