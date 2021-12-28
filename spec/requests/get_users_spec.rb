require 'rails_helper'

describe "get all users route", :type => :request do
	let!(:users) {FactoryBot.create_list(:user, 20)}

	before {
		get '/api/v1/users', params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	}

	it 'should return all users' do
		expect(JSON.parse(response.body)['users'].size).to eq(20)
	end

	it 'should return status code 200' do
		expect(response).to have_http_status(:success)
	end
end