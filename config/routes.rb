Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do
    resources :users, only: [:show]
  end

  root to: 'home#index'
end
