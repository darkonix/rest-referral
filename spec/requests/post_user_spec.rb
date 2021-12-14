require 'rails_helper'

describe "create an user route", :type => :request do
	let!(:user_attrs) { attributes_for(:user) }

	before do
		post '/api/v1/users', params: user_attrs
	end

	it 'returns the user\'s name' do
		expect(JSON.parse(response.body)['user']['name']).to eq(user_attrs[:name])
	end

	it 'returns the user\'s email' do
		expect(JSON.parse(response.body)['user']['email']).to eq(user_attrs[:email])
	end

	# TO DO: review expect
	# it 'returns the user\'s referrals' do
	# 	expect(JSON.parse(response.body)['referrals']).to eq('referrals')
	# end

	it 'returns a created status' do
		expect(response).to have_http_status(:created)
	end

	it "email addresses should be unique" do
		post '/api/v1/users', params: user_attrs
		expect(response).to have_http_status(:internal_server_error)
	end

	it "password should have at least 8 characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 1, max_length: 7)
		post '/api/v1/users', params: user_attrs
		expect(response).to have_http_status(:bad_request)
	end

	it "password should have a maximum of 20 characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 21, max_length: 30)
		post '/api/v1/users', params: user_attrs
		expect(response).to have_http_status(:bad_request)
	end

	it "password should have mixed case" do
		user_attrs[:password] = Faker::Internet.password(min_length: 8, max_length: 20, mix_case: false)
		post '/api/v1/users', params: user_attrs
		expect(response).to have_http_status(:bad_request)
	end

	it "password should contain special characters" do
		user_attrs[:password] = Faker::Internet.password(min_length: 8, max_length: 20, special_characters: false)
		post '/api/v1/users', params: user_attrs
		expect(response).to have_http_status(:bad_request)
	end
end