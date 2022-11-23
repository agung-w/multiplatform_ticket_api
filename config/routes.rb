Rails.application.routes.draw do
  resources :transactions
  resources :orders
  resources :studios
  resources :cinemas
  resources :wallets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/auth/:provider/callback'=>'authentication/auth#omniauth'
  namespace :api do
    namespace :v1 do
      resources :users
    end
    get '/user_info/:id'=>'user#user_info'
  end
  
end
