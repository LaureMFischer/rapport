Rapport::Application.routes.draw do
  devise_for :users
  resources :connections
  root to: 'connections#index'
end
