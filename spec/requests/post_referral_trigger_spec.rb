require 'rails_helper'

describe "trigger a referral route", :type => :request do
	let!(:user) { create(:user) }
	let!(:referral) do
		post "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		JSON.parse(response.body)['referral']
	end
	let!(:new_user) { create(:user) }

	before do
		post "/api/v1/referrals/#{referral['code']}/trigger", params: { user_id: new_user.id }, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	end

	it 'should return the referral\'s code' do
		expect(JSON.parse(response.body)['referral']['code']).to eq(referral['code'])
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end

	it 'should increase signup count when triggered' do
		expect(JSON.parse(response.body)['referral']['signups']).to eq(referral['signups'] + 1)
	end

	it 'should increase the new user balance in $10' do
		get "/api/v1/users/#{new_user.id}/balance", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] } do
			expect(JSON.parse(response.body)['balance']).to eq(new_user['balance'] + 10)
		end
	end

	it 'should increase user\'s balance in $10 whenever it\'s triggered 5 times' do
		# Call only enough times to reach the next multiple of 5
		(5 - (JSON.parse(response.body)['referral']['signups'] % 5)).times do
			post "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		end

		get "/api/v1/users/#{user.id}/balance", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] } do
			expect(JSON.parse(response.body)['balance']).to eq(user['balance'] + 10)
		end
	end
end