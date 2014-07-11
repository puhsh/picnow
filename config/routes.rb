Rails.application.routes.draw do
  devise_for :users
  # API routes
  namespace :v1 do

  end

  root to: 'home#index'
end
