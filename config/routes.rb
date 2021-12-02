Rails.application.routes.draw do

  resources :referrals
  resources :users
  mount ReferralProgram::Api => '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
