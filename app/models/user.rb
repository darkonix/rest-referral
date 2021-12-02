class User < ApplicationRecord
	has_one :referral, dependent: :destroy
end
