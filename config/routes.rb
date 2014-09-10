Rails.application.routes.draw do
  devise_for :users

  # API routes
  namespace :v1 do
    post 'auth', to: 'auth#create'

    resources :users, only: [:show, :create, :update] do

      resources :groups, only: [:index, :show, :create] do
        resources :users, only: [:index]
        resources :comments, only: [:create]

        member do 
          get :activity
        end

      end

      resources :photos, only: [:create]
      resources :devices, only: [:create]
      resources :invites, only: [:create]
      resources :text_verifications, only: [:create, :update]
    end
  end

  root to: 'home#index'
end
