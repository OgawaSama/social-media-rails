Rails.application.routes.draw do
  resources :profiles
  # get "profile/show"
  # get "profile/edit"
  resources :posts

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "feed", to: "feed#show", as: :feed

  get "up" => "rails/health#show", as: :rails_health_check

  get "feed/search", to: "feed#search", as: "search_users"

  authenticated :user do
    root to: "feed#show", as: :authenticated_user_root
  end

  root "pages#home"
end
