 require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    let!(:user) { create(:user) }
    it "returns success code" do
      get '/api/v1/users'
      expect(response).to have_http_status(200)
    end

    it 'returns all users' do
      users = User.all
      get '/api/v1/users'
      expect(JSON.parse(response.body)).to eq(JSON.parse(users.to_json))
    end
  end

  describe "GET /users/:id" do
    let!(:user) { create(:user) }
    it 'returns 404 status for an invalid id' do
      get '/api/v1/users/1000'
      expect(response).to have_http_status(404)
    end

    it 'return specific user' do
      get "/api/v1/users/#{user.id}"
      expect(JSON.parse(response.body)['user']).to eq(JSON.parse(user.to_json))
    end
  end

  describe "POST /users" do
    let!(:params) { attributes_for(:user) }

    context 'Valid params' do
      it 'creates a new user' do
        post '/api/v1/users', params: params
        expect(JSON.parse(response.body)['user']['email']).to eq(params[:email])
      end

      it 'returns 201 status' do
        post '/api/v1/users', params: params
        expect(response).to have_http_status(201)
      end
    end

    context 'Invalid params' do
      it 'returns empty name error' do
        params[:name] = ''
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('name is empty')
      end

      it 'returns empty email error' do
        params[:email] = ''
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('email is empty')
      end

      it 'returns empty password error' do
        params[:password] = ''
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('password is empty')
      end

      it 'returns name validation error' do
        params.delete(:name)
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('name is missing, name is empty')
      end

      it 'returns email validation error' do
        params.delete(:email)
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('email is missing, email is empty')
      end

      it 'returns password validation error' do
        params.delete(:password)
        post '/api/v1/users', params: params
        puts response.body.inspect
        expect(JSON.parse(response.body)['error']).to eq('password is missing, password is empty')
      end
    end
  end

  describe "PUT /users" do
    let!(:user_attrs) { attributes_for(:user) }
    let!(:user) { create(:user) }

    context 'Valid params' do
      it 'updates the existing record' do
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(user.reload.name).to eq(user_attrs[:name])
      end

      it 'returns success response' do
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['message']).to eq('User updated succesfully')
      end
    end

    context 'Invalid params' do
      it 'returns empty name error' do
        user_attrs[:name] = nil
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('name is empty')
      end

      it 'returns empty email error' do
        user_attrs[:email] = nil
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('email is empty')
      end

      it 'returns empty password error' do
        user_attrs[:password] = nil
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('password is empty')
      end

      it 'returns missing name error' do
        user_attrs.delete(:name)
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('name is missing, name is empty')
      end

      it 'returns missing email error' do
        user_attrs.delete(:email)
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('email is missing, email is empty')
      end

      it 'returns missing password error' do
        user_attrs.delete(:password)
        put "/api/v1/users/#{user.id}", params: user_attrs
        expect(JSON.parse(response.body)['error']).to eq('password is missing, password is empty')
      end
    end
  end

  describe 'DELETE /users/:id' do
    let!(:user) { create(:user) }
    it 'deletes the user' do
      delete "/api/v1/users/#{user.id}"
      expect(JSON.parse(response.body)['message']).to eq('User deleted succesfully')
    end

    it 'returns 404 status for an invalid id' do
      delete '/api/v1/users/1000'
      expect(response).to have_http_status(404)
    end
  end
end
