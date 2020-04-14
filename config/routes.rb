Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'pages/dashboard', to: 'pages#dashboard'
  get 'pages/home', to: 'pages#home'
  get 'pages/masks', to: 'pages#masks'
  get 'pages/reservations', to: 'pages#reservations'
  get 'pages/reviews', to: 'pages#reviews'
  resources :masks, only: %i[index new create edit show update] do
    resources :reservations, only: %i[new create edit show update]
  end
  resources :reservations, only: %i[index show update]

  resources :reviews, only: %i[new create]
end
