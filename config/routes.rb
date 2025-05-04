Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    root "main#index"

    # Users
    resources :users, only: [:show, :new, :create]
    get "/signup", to: "users#new", as: :signup
    get "/help", to: "main#help", as: :help

    # Sessions
    resources :sessions, only: [:new, :create, :destroy]
    get "/signin", to: "sessions#new", as: :signin
    delete "/signout", to: "sessions#destroy", as: :signout

    # Resources
    resources :themes, :images
    post '/values', to: 'values#create', as: 'create_value'  # Явное определение

    # Work
    get "work", to: "work#index"
    post "display_theme", to: "work#display_theme"
    get "image/:image_id", to: "work#show_image", as: :show_image

    # API
    namespace :api do
      get "next_image", to: "api#next_image"
      get "prev_image", to: "api#prev_image"
    end

    # Main
    get "contacts", to: "main#contacts"
    get "about", to: "main#about"
  end
end