require 'rails_helper'

describe "delete an user route" do
	let!(:user_one) { create(:user) }
	let!(:user_two) { create(:user) }

	it 'should delete the user' do
		get "/api/v1/users" do
			expect(response).to have_http_status(:success)
			expect(JSON.parse(response.body)).to include(user_one.to_json, user_two.to_json)
		end

		delete "/api/v1/users/@{user_one.id}" do
			expect(response).to have_http_status(:no_content)
		end

		get "/api/v1/users" do
			expect(response).to have_http_status(:success)
			expect(JSON.parse(response.body)).to include(user_two.to_json)
		end
	end
end