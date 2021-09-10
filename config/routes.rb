Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks do
        put :perform, on: :member
      end

      resources :notifications, only: :index do
        put :read, on: :member
        put :unread, on: :member
      end

      post '/signup', to: 'users#create'
      post '/authenticate', to: 'authentication#authenticate'
    end
  end
end
