require 'rails_helper'

describe "create an user route", :type => :request do
	let!(:user_attrs) { attributes_for(:user) }

	before do
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
	end

	it 'should return the user\'s name' do
		expect(JSON.parse(response.body)['user']['name']).to eq(user_attrs[:name])
	end

	it 'should return the user\'s email' do
		expect(JSON.parse(response.body)['user']['email']).to eq(user_attrs[:email])
	end

	it 'should return a created status' do
		expect(response).to have_http_status(:created)
	end

	it "should return error if email addresses isn't unique" do
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		expect(response).to have_http_status(:internal_server_error)
	end

	it "should return error if password is shorter than 8 characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 1, max_length: 7)
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		expect(response).to have_http_status(:bad_request)
	end

	it "should return error if password is longer than 20 characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 21, max_length: 30)
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		expect(response).to have_http_status(:bad_request)
	end

	it "should return error if password isn't mixed case" do
		user_attrs[:password] = Faker::Internet.password(min_length: 8, max_length: 20, mix_case: false)
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		expect(response).to have_http_status(:bad_request)
	end

	it "should return error if password doesn't contain special characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 8, max_length: 20, special_characters: false)
		post '/api/v1/users', params: user_attrs, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
		expect(response).to have_http_status(:bad_request)
	end
end