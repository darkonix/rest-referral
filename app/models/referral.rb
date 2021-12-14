class Referral < ApplicationRecord
  belongs_to :user, touch: true

  has_secure_token :code

  attribute :signups, :integer, default: 0
end
