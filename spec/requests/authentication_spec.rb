require 'rails_helper'

describe "API authentication" do
  let!(:user) { create(:user) }

  it 'should deny access for empty token' do
    get '/api/v1/users'
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should deny access for invalid token' do
    get '/api/v1/users', params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Faker::String.random }
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should grant access for valid token' do
    get '/api/v1/users', params: {}, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] }
    expect(response).to have_http_status(:success)
  end
end