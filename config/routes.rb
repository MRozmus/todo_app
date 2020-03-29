Rails.application.routes.draw do
  resources :todos
  root to: "todos#index"
  put "/status/:id", to: "todos#status", as: "status"
  post "/status/:id", to: "todos#status"
end
