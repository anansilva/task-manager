Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i[index create]

      post '/signup', to: 'users#create'
      post '/authenticate', to: 'authentication#authenticate'
    end
  end
end
