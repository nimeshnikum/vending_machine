Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
    end

    namespace :v1 do
      resources :products
      resources :users

      post '/deposit', :to => 'deposits#create'
    end
  end
end
