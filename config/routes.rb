Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post"/login",to:"users#login"
  post"/users/current",to:"users#current"
  post"/join",to:"users#join"
  post"/refresh",to:"games#refresh"
  get"/logout",to:"users#logout"

  post"/newgame",to:"games#newgame"
  post"/dragcard",to:"games#dragcard"
  post"/stop",to:"games#stop"
  post"/winner",to:"games#winner"
  post"/finish",to:"games#finish"

  resources :games, only: [:index, :create]
  resources :users, only: [:create, :show]
end
