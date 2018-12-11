Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/showbad', to: 'spreadsheet_import#show_bad_users', as: "show_bad_users"

  resources :users
  resources :spreadsheet_import, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
end
