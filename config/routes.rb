Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do
    resources :users, only: [:show, :create] do
      resources :groups, only: [:index, :show, :create]
      resources :photos, only: [:create]
    end

    resources :groups, only: [:show] do
      resources :photos, only: [:index]
    end
  end

  root to: 'home#index'
end
