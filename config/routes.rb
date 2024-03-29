Rails.application.routes.draw do
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/auth/:provider/callback'=>'authentication/auth#omniauth'
  get '/auth/phone'=>'authentication/auth#phone_registration'
 
  post '/auth/login'=>'authentication/auth#login_by_phone'
  namespace :api do
    namespace :v1 do
      resources :users
      get '/wallet/user_balance', to: 'wallets#show_user_wallet'
      post '/wallet/activate', to: 'wallets#activate'
      put '/wallet/top_up', to: 'wallets#top_up'

      get 'user/detail', to: 'users#user_detail'
      post 'user/register'=>'users#register_by_phone'
      post 'user/verifyphone'=>'users#verify_phone'
      put 'user/createpassword'=>'users#create_password'
      put 'user/add_email'=>'users#add_email'
      post 'user/get_change_password_token'=>'users#get_change_password_token'
      put 'user/change_password'=>'users#change_password'

      post 'order/ticket'=>'orders#order_ticket'
      post 'order/cancel'=>'orders#cancel_order'
      
      post 'pay/ticket'=>'orders#pay_ticket_order'

      get 'ticket/all'=>'orders#all_ticket'
      get 'ticket/active'=>'orders#active_ticket'

      get 'studio_detail', to: 'studios#studio_detail'
      post 'studio/reserved_seat', to: 'studios#get_reserved_seat'
      get 'cinemas', to: 'cinemas#index'

      get'/movies/scrape',to: 'movies#scrape'
      get'/movies',to: 'movies#index'

      get '/transactions/show',to: 'transactions#show'
      # resources :transactions
      # resources :orders
      # resources :studios
      # resources :cinemas
      # resources :wallets
    end
  end
  
  
end
