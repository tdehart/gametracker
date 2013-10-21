Gametracker::Application.routes.draw do
  match '/landing', :to => 'static_pages#landing', via: 'get'
  match '/about', :to => 'static_pages#about', via: 'get'

  resources :tournaments do
    collection do
      get 'all'
    end
  end
  resources :events
  resources :developers
  resources :games
  resources :streamers
  resources :streams
  resources :users do
    member do
      get 'toggle_admin'
    end
  end
  match '/feed', to: 'users#feed', via: 'get'
  match '/home', to: 'users#home', via: 'get'
  resources :web_resources
  resources :regions
  resources :sessions, only: [:new, :create, :destroy]
  resources :followed_tournaments, only: [:create, :destroy]
  resources :followed_games, only: [:create, :destroy]

  root :to => "static_pages#landing"

  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: :delete
end
