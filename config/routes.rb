Rails.application.routes.draw do
  get "event_availabilities/show"
  get "event_availabilities/create"
  get "event_availabilities/update"
  get "events/new"
  get "events/create"
  get "events/show"
  resources :businesses, only: [ :new, :create, :edit, :update, :show ] do
    resource :cardapio, only: [ :new, :create, :edit, :update ]
  end
  resources :profiles
  resources :posts, only: [ :show, :new, :edit, :create, :update, :destroy ] do
    scope module: :posts do
      resources :reactions, only: [ :create, :destroy ]
      resources :comments, only: [ :new, :create, :index, :destroy ]
    end
  end

  # Rota para remover imagem de um post
  delete "remove_image/:signed_id", to: "posts#remove_image", as: :remove_image

  resources :groups
  resources :friendships
  resources :relationships, only: [ :create, :destroy ]



  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Rota para rolês
  resources :events, only: [:new, :create, :show] do
    # Rota para a página de "Marcar Disponibilidade"
    resource :my_availability, only: [:show, :create, :update], controller: 'event_availabilities'
  end

  # Rotas para followers/following
  resources :users, only: [] do
    member do
      get :followers
      get :following
      post :follow, to: "relationships#create"
      delete :unfollow, to: "relationships#destroy"

      get :groups
    end
  end

  post :add_member, to: "groups#add_member"
  post :remove_member, to: "groups#remove_member"
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
