Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/auth/:provider/callback'=>'authentication/auth#omniauth'
  get '/auth/phone'=>'authentication/auth#phone_registration'
  post '/auth/register'=>'authentication/auth#register_by_phone'
  post '/auth/verifyphone'=>'authentication/auth#verify_phone'
  put '/auth/createpassword'=>'authentication/auth#create_password'
  get '/auth/login'=>'authentication/auth#login_by_phone'
  namespace :api do
    namespace :v1 do
      resources :users
      get 'user_detail', to: 'users#user_detail'
      get 'studio_detail', to: 'studios#studio_detail'
      get'/movies/scrape',to: 'movies#scrape'
      get'/movies',to: 'movies#index'

      # resources :transactions
      # resources :orders
      # resources :studios
      # resources :cinemas
      # resources :wallets
    end
  end
  
  
end
