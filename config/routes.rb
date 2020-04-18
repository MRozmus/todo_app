Rails.application.routes.draw do
  devise_for :users
  resources :todos
  root to: "todos#index"
  put "/status/:id", to: "todos#status", as: "status"
  post "/status/:id", to: "todos#status"
  put "/migrate", to: "todos#migrate", as: "migrate"
  resources :friends, except: [:edit, :update]
  put "/friends/status", to: "friends#status", as: "status_friend"
  post "/friends/status", to: "friends#status"
  resources :shares, except: [:new, :edit, :update]
end
