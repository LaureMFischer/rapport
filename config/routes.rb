Rapport::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  resources :connections
  root to: 'connections#index'
end
