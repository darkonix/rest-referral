module ReferralProgram
	module V1
		class Users < ReferralProgram::Base
			resources :users do
				#  get /api/v1/users
				desc 'List all users' do
					summary 'List all users'
					params  ReferralProgram::Entities::User.documentation
					success ReferralProgram::Entities::User
					is_array true
					produces ['application/json']
					tags ['Users']
				end
				get do
          users = User.all
          { users: ReferralProgram::Entities::User.represent(users).as_json }
				end

				#  post /api/v1/users
				desc 'Create an user' do
					summary 'Create an user'
					params  ReferralProgram::Entities::User.documentation
					success ReferralProgram::Entities::User
					is_array false
					produces ['application/json']
					consumes ['application/json']
					tags ['Users']
				end
				params do
					requires :name, type: String, allow_blank: false
					requires :email, type: String, allow_blank: false, regexp: /.+@.+/
					requires :password, type: String, allow_blank: false
					requires :password_confirmation, type: String, allow_blank: false, same_as: :password
					optional :balance, type: Float
					# optional :referrals, type: Set[Referral]
				end
				post do
					user = User.create!(declared(params))
          { user: ReferralProgram::Entities::User.represent(user).as_json }
				end

				route_param :id, type: Integer do
					#  get /api/v1/users/:id
					desc 'Get specific user' do
						summary 'Get specific user'
						params  ReferralProgram::Entities::User.documentation
						success ReferralProgram::Entities::User
						is_array false
						produces ['application/json']
						tags ['Users']
					end
					get do
						user = User.find(params[:id])
						{ user: ReferralProgram::Entities::User.represent(user).as_json }
					end

					#  get /api/v1/users/:id/balance
					desc 'Get a specific user\'s balance' do
						summary 'Get user\'s balance'
						is_array false
						produces ['application/json']
						tags ['Users']
					end
					get 'balance' do
						user = User.find(params[:id])
						{ balance: user.balance }
					end

					# put /api/v1/users/:id
					desc 'Update an user' do
						summary 'Update an user'
						params  ReferralProgram::Entities::User.documentation
						success ReferralProgram::Entities::User
						is_array false
						consumes ['application/json']
						produces ['application/json']
						tags ['Users']
					end
					params do
						requires :name, type: String, allow_blank: false
						requires :email, type: String, allow_blank: false, regexp: /.+@.+/
						requires :password, type: String, allow_blank: false
						requires :password_confirmation, type: String, allow_blank: false, same_as: :password
						optional :balance, type: Float
						# optional :referrals, type: Set[Referral]
					end
					put do
						user = User.find(params[:id])
						user.update(declared(params))
						{ messages: ['User updated succesfully'] }
					end

					# delete /api/v1/users/:id
					desc 'Delete an user' do
						summary 'Delete an user'
						params  ReferralProgram::Entities::User.documentation
						success ReferralProgram::Entities::User
						is_array false
						produces ['application/json']
						tags ['Users']
					end
					delete do
						User.find(params[:id]).delete
						{ messages: ['User deleted succesfully'] }
					end

					resources :referrals do
						# get /api/v1/users/:id/referrals
						desc 'List all referrals of an user' do
							summary 'List all referrals'
							params  ReferralProgram::Entities::Referral.documentation
							success ReferralProgram::Entities::Referral
							is_array true
							produces ['application/json']
							tags ['Referrals']
						end
						get do
							user = User.find(params[:id])
							referrals = user.referrals
							{ referrals: ReferralProgram::Entities::Referral.represent(referrals).as_json }
						end

						# post /api/v1/users/:id/referrals
						desc 'Create a referral' do
							summary 'Create a referral'
							params  ReferralProgram::Entities::Referral.documentation
							success ReferralProgram::Entities::Referral
							is_array false
							produces ['application/json']
							tags ['Referrals']
						end
						post do
							user = User.find(params[:id])
							referral = user.referrals.create()
							{ referral: ReferralProgram::Entities::Referral.represent(referral).as_json, messages: ['Referral created succesfully']}
						end

						route_param :ref do
							# get /api/v1/users/:id/referrals/:ref
							desc 'Get specific referral' do
								summary 'Get specific referral'
								params  ReferralProgram::Entities::Referral.documentation
								success ReferralProgram::Entities::Referral
								is_array false
								produces ['application/json']
								tags ['Referrals']
							end
							get do
								referral = Referral.find(params[:ref])
								{ referral: ReferralProgram::Entities::Referral.represent(referral).as_json }
							end

							# post /api/v1/users/:id/referrals/:ref/trigger
							desc 'Trigger a referral' do
								summary 'Trigger a referral'
								params  ReferralProgram::Entities::Referral.documentation
								success ReferralProgram::Entities::Referral
								is_array false
								produces ['application/json']
								tags ['Referrals']
							end
							post 'trigger' do
								referral = Referral.find(params[:ref])
								referral.increment!(:signups)
								if (referral.signups % 5 == 0)
									referral.user.increment!(:balance, 10)
								end
								{ referral: ReferralProgram::Entities::Referral.represent(referral).as_json, messages: ['Referral triggered succesfully']}
							end

							# delete /api/v1/users/:id/referrals/:ref
							desc 'Delete a referral' do
								summary 'Delete a referral'
								params  ReferralProgram::Entities::Referral.documentation
								success ReferralProgram::Entities::Referral
								is_array false
								produces ['application/json']
								tags ['Referrals']
							end
							delete do
								Referral.find(params[:id]).delete
								{ messages: ['Referral deleted succesfully'] }
							end
						end
					end
				end
			end
		end
	end
end