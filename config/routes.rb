Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'pages/dashboard', to: 'pages#dashboard'
  get 'pages/home', to: 'pages#home'
  post 'masks/:mask_id/reservations/:id', to: 'reservations#confirm', as: 'confirm_reservation'
  resources :masks, only: %i[index new create edit show update] do
    resources :reservations, only: %i[new create edit show update]
  end
  resources :reservations, only: %i[index show update]

  resources :reviews, only: %i[new create]
end
