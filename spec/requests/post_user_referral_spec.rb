require 'rails_helper'

describe "create an user's referral route", :type => :request do
	let!(:user) { create(:user) }

	before do
		post "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	end

	it 'should return a created status' do
		expect(response).to have_http_status(:created)
	end
end