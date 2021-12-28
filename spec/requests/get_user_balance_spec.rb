require 'rails_helper'

describe "get an user's balance route", :type => :request do
	let!(:user) { create(:user) }

	before {
		get "/api/v1/users/#{user.id}/balance", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	}

	it 'should return the user\'s balance' do
		expect(JSON.parse(response.body)['balance']).to eq(user[:balance].to_s)
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end
end