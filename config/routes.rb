Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do
    resources :users, only: [:show, :create] do
      resources :groups, only: [:index, :show, :create]
    end
  end

  root to: 'home#index'
end
