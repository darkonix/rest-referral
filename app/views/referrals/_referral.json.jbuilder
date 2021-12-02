json.extract! referral, :id, :user_id, :code, :signups, :created_at, :updated_at
json.url referral_url(referral, format: :json)
