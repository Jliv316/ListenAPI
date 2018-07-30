Rails.application.routes.draw do
  root                             to: 'home#index'
  get '/auth/spotify/callback',  to: 'sessions#create'
  get '/logout',                   to: 'sessions#destroy'
  get '/dashboard',                to: 'dashboard#show'
  resources :player, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :playlists
      resources :location
      resources :party
    end
  end
end