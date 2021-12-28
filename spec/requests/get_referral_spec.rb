require 'rails_helper'

describe "get a specific referral route", :type => :request do
	let!(:user) { create(:user) }
	let!(:referral) do
		post "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		JSON.parse(response.body)['referral']
	end

	before do
		get "/api/v1/referrals/#{referral['code']}", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	end

	it 'should return the referral\'s code' do
		expect(JSON.parse(response.body)['referral']['code']).to eq(referral['code'])
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end
end