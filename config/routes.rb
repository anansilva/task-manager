Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks do
        post :perform, on: :member
      end

      resources :notifications, only: :index

      post '/signup', to: 'users#create'
      post '/authenticate', to: 'authentication#authenticate'
    end
  end
end
