Rails.application.routes.draw do
  resources :todos
  root to: "todos#index"
  post "/status/:id", to: "todos#status", as: "status"
end
