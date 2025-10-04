Rails.application.routes.draw do
  resources :profiles
  resources :posts do
    scope module: :posts do
      resources :reactions, only: [:create]
      resources :comments, only: [:new, :create, :index]
    end
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  get "pages/userindex", as: "userindex"
  get "pages/barindex", as: "barindex"

  get "feed", to: "feed#show", as: :feed

  get "up" => "rails/health#show", as: :rails_health_check

  get "feed/search", to: "feed#search", as: "search_users"

  authenticated :user do
    root to: "feed#show", as: :authenticated_user_root
  end

  root "pages#home"
end
