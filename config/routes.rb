Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post"/users/login",to:"users#login"
  post"/users/current",to:"users#current"
  get"/users/logout",to:"users#logout"
  
  post"/games/:game_id/join",to:"games#join"
  get"/games/:game_id/refresh",to:"games#refresh"
  post"/games/:game_id/newgame",to:"games#newgame"
  post"/games/:game_id/dragcard",to:"games#dragcard"
  get"/users/:id/stop",to:"users#stop"
  post"/games/:game_id/winner",to:"games#winner"

  resources :users, only: [:create, :show]
  resources :games, only: [:index, :create]
end
