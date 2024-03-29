Rails.application.routes.draw do
  resources :trains
  resources :tickets
  resources :reviews
  resources :passengers
  resources :admins
  resources :transactions
  root 'home#index'
  
  get 'passenger_search', to: 'passengers#passenger_search', as: 'passenger_search'
  get 'ticket_book', to: 'tickets#ticket_book', as: 'ticket_book'
  post 'ticket_book_create', to: 'tickets#ticket_book_create', as:'ticket_book_create'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'passengers#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # get 'delete_passenger/:id', to: 'passengers#destroy', as: 'delete_passenger'
  get 'delete_admin/:id', to: 'admins#destroy', as: 'delete_admin'
  resources :admin_sessions, only: [:new, :create, :destroy]
  get 'admin_login', to: 'admin_sessions#new', as: 'admin_login'
  get 'admin_logout', to: 'admin_sessions#destroy', as: 'admin_logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
