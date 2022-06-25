Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post"/users/current",to:"users#current"
  post"/login",to:"users#login"
  get"/logout",to:"users#logout"
  post"/fill",to:"games#fill"
  post"/winner",to:"games#winner"
  
  post"/join",to:"blackjacks#join"
  post"/refresh",to:"blackjacks#refresh"
  resources :games, only: [:index, :create]
  resources :users, only: [:create, :show]
end
