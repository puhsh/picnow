Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do
    resources :users, only: [:show, :create] do
      resources :groups, only: [:index, :show, :create] do
        resources :photos, only: [:index]
        resources :users, only: [:index]
      end
      resources :photos, only: [:create]
    end
  end

  root to: 'home#index'
end
