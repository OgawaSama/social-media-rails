Rails.application.routes.draw do
  resource :business_registration, only: [ :new, :create, :edit, :update ]
  resources :profiles
  resources :posts do
    scope module: :posts do
      resources :reactions, only: [ :create, :destroy ]
      resources :comments, only: [ :new, :create, :index, :destroy ]
    end
  end

  resources :friendships
  resources :relationships, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Rotas para followers/following
  resources :users, only: [] do
    member do
      get :followers
      get :following
      post :follow, to: 'relationships#create'
      delete :unfollow, to: 'relationships#destroy'
    end
  end

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
