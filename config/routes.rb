Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :passwords], controllers: { passwords: 'passwords' }

  devise_scope :user do
    get '/password/reset' => 'passwords#edit', as: 'edit_user_password'
    patch '/password' => 'passwords#update'
    put '/password' => 'passwords#update'
  end

  # API routes
  namespace :v1 do
    devise_for :users, only: [:passwords]
    devise_scope :user do
      post '/passwords' => 'passwords#create'
    end
    post 'auth', to: 'auth#create'

    resources :users, only: [:show, :create, :update] do

      member do
        post :avatar
        get :friends
        get :friends_from_contacts
        post :friends_from_contacts
      end

      resources :groups, only: [:index, :show, :create, :destroy] do
        resources :users, only: [:index]
        resources :comments, only: [:create]
        resources :invites, only: [:create]
        resources :group_users, only: [:create] do 
          collection do
            delete :remove
          end
        end
        resources :notifications, only: [:index] do
          collection do
            post :mark_as_read
          end
        end

        resources :invites, only: [:create]
        resources :events, only: [:index]
      end

      resources :photos, only: [:create]

      resources :devices, only: [:create]
      resources :text_verifications, only: [:create, :update]
    end
    resources :passwords, only: [:create]
  end

  root to: 'home#index'

  get '/:name', to: 'home#show', as: 'app_store_redirect'
end
