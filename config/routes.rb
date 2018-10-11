Rails.application.routes.draw do
  root 'logs#home'
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'logs' => "logs#index", as: "log"
  get '/something' => "logs#something", as: "something"
end
