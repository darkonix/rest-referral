require 'rails_helper'

describe "get a single user route", :type => :request do
	let!(:user) { create(:user) }

	before {
		get "/api/v1/users/#{user.id}", params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	}

	it 'should return the user\'s name' do
		expect(JSON.parse(response.body)['user']['name']).to eq(user[:name])
	end

	it 'should return the user\'s email' do
		expect(JSON.parse(response.body)['user']['email']).to eq(user[:email])
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end
end