Rails.application.routes.draw do
  devise_for :users

  # API routes
  namespace :v1 do
    post 'auth', to: 'auth#create'

    resources :users, only: [:show, :create, :update] do

      member do
        post :avatar
        get :friends
      end

      resources :groups, only: [:index, :show, :create] do
        resources :users, only: [:index]
        resources :comments, only: [:create]
        resources :photos, only: [:create]
        resources :invites, only: [:create]
        resources :group_users, only: [:create, :destroy]
        resources :notifications, only: [] do
          collection do
            post :mark_as_read
          end
        end

        member do 
          get :activity
        end

      end

      resources :devices, only: [:create]
      resources :text_verifications, only: [:create, :update]
    end
  end

  root to: 'home#index'

  get '/:name', to: 'home#index'
end
