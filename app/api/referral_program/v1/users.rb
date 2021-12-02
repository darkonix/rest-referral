module ReferralProgram
	module V1
		class Users < ReferralProgram::Api
			resources :users do
				#  get /api/v1/users
				desc 'Return all users'
				get do
					User.all
				end

				desc 'Return specific user'
				#  get /api/v1/users/:id
				route_param :id, type: Integer do
					get do
						user = User.find(params[:id])
						{ user: user }
					rescue ActiveRecord::RecordNotFound
						error!('Record Not Found', 404)
					end
				end

				desc 'Create an user object'
				#  post /api/v1/users
				params do
					requires :name, type: String, allow_blank: false
					requires :email, type: String, allow_blank: false
					requires :password, type: String, allow_blank: false
					optional :balance, type: Integer
				end
				post do
					user = User.create!(declared(params))
					{ user: user, message: 'Account created succesfully'}
				end

				desc 'Update an existing user object'
				# put /api/v1/users/:id
				params do
					requires :name, type: String, allow_blank: false
					requires :email, type: String, allow_blank: false
					requires :password, type: String, allow_blank: false
					optional :balance, type: Integer
				end
				route_param :id, type: Integer do
					put do
						user = User.find(params[:id])
						user.update(declared(params))
						{ message: 'User updated succesfully' }
					rescue ActiveRecord::RecordNotFound
						error!('Record Not Found', 404)
					end
				end

				desc 'Delete an existing user object'
				# delete /api/v1/users/:id
				route_param :id, type: Integer do
					delete do
						User.find(params[:id]).delete
						{ message: 'User deleted succesfully' }
					rescue ActiveRecord::RecordNotFound
						error!('Record Not Found', 404)
					end
				end
			end
		end
	end
end