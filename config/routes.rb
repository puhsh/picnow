Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do
    resources :users, only: [:show] do
      resources :groups, only: [:index, :show]
    end
  end

  root to: 'home#index'
end
