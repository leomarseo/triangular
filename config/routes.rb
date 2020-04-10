Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  get '/dashboard', to: 'pages#dashboard'
  resources :masks, only: %i[index new create edit show update] do
    resources :reservations, only: %i[new create edit show update]
  end

  resources :reviews
end
