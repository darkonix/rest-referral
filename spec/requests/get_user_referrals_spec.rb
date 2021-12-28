require 'rails_helper'

describe "get all referrals of an user route", :type => :request do
	let!(:user) { create(:user) }
	let!(:referral) do
		post "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		JSON.parse(response.body)['referral']
	end

	before do
		get "/api/v1/users/#{user.id}/referrals", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	end

	it 'should return the user\'s referrals' do
		expect(JSON.parse(response.body)['referrals'].size).to eq(user.referrals.count)
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end
end