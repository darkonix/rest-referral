require 'rails_helper'

describe "update an user route" do
	let!(:user) { create(:user) }

	it 'updates an user' do
		new_name = Faker::Name.name

		put "/api/v1/users/#{user.id}", params: { name: new_name }, headers: { 'AUTHORIZATION' => "Bearer " + Rails.application.credentials.auth0[:token] } do
			expect(response).to have_http_status(:accepted)
			expect(User.find(user.id).name).to eq(new_name)
		end
	end
end