Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "listings#index"
  resources :listings do
    resources :reservations, only: %i(new create edit show update)
  end
  resources :users, only: %i(new create edit show update destroy)
  resources :masks, only: %i(new create edit show update)
  resources :reviews
end
