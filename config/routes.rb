Rails.application.routes.draw do
  devise_for :users
  resources :todos
  root to: "todos#index"
  put "/status/:id", to: "todos#status", as: "status"
  post "/status/:id", to: "todos#status"
  put "/migrate", to: "todos#migrate", as: "migrate"
end
