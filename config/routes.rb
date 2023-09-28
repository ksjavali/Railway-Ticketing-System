Rails.application.routes.draw do
  resources :trains
  resources :tickets
  resources :reviews
  resources :passengers
  resources :admins
  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'passengers#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'delete_user/:id', to: 'users#destroy', as: 'delete_user'
  get 'delete_admin/:id', to: 'admins#destroy', as: 'delete_admin'
  resources :admin_sessions, only: [:new, :create, :destroy]
  get 'admin_login', to: 'sessions#new', as: 'admin_login'
  get 'admin_logout', to: 'admin_sessions#destroy', as: 'admin_logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
