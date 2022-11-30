Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/auth/:provider/callback'=>'authentication/auth#omniauth'
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
