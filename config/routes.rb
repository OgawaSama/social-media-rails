Rails.application.routes.draw do
  resources :businesses, only: [ :index, :new, :create, :edit, :update, :show ] do
    resources :business_comments, only: [ :create, :index, :destroy ]
    resources :business_addresses do
      resources :events do
        resources :event_participations, only: [ :create ]
      end
      resource :cardapio, only: [ :new, :create, :edit, :update, :show ] do
        resources :item_cardapio_comments, only: [ :create, :index, :destroy ]
      end
    end

    # Rotas para seguir/deixar de seguir bares
    member do
      post :follow, to: "business_relationships#create"
      delete :unfollow, to: "business_relationships#destroy"
    end
  end

  resources :profiles
  resources :posts, only: [ :show, :new, :edit, :create, :update, :destroy ] do
    scope module: :posts do
      resources :reactions, only: [ :create, :destroy ]
      resources :comments, only: [ :new, :create, :index, :destroy ]
    end
  end
  
  resources :events, only: [:new, :create, :show] do
    resource :my_availability, only: [:show, :create, :update], controller: 'event_availabilities'
  end

  resources :items_consumed do
    collection do
      get :summary
    end
  end
  post :add_item_consumed, to: "items_consumed#create", as: "add_item_consumed"
  get :consumption_ranking, to: "items_consumed#ranking", as: "consumption_ranking"
  post :celebrate_user, to: "users#celebrate_user", as: "celebrate_user"
  get :friends_ranking, to: "items_consumed#friends_ranking", as: "friends_ranking"

  # Rota para remover imagem de um post
  delete "remove_image/:signed_id", to: "posts#remove_image", as: :remove_image

  resources :groups
  resources :friendships
  resources :relationships, only: [ :create, :destroy ]
  resources :business_relationships, only: [ :create, :destroy ]

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }


  # Rotas para followers/following de usuários
  resources :users, only: [] do
    member do
      get :followers
      get :following
      post :follow, to: "relationships#create"
      delete :unfollow, to: "relationships#destroy"
      get :groups
      get :following_businesses
    end
  end

  post :add_member, to: "groups#add_member"
  post :remove_member, to: "groups#remove_member"
  post :add_rating, to: "businesses#add_rating"
  post :add_item_rating, to: "item_cardapios#add_rating"
  get "pages/userindex", as: "userindex"
  get "pages/barindex", as: "barindex"

  get "feed", to: "feed#show", as: :feed

  get "up" => "rails/health#show", as: :rails_health_check

  get "feed/search", to: "feed#search", as: "search_users"
  get "feed/search_shops", to: "feed#search_shops", as: "search_shops"
  get "feed/search_bars", to: "feed#search_bars", as: "search_bars"

  authenticated :user do
    root to: "feed#show", as: :authenticated_user_root
  end

  root "pages#home"
end
