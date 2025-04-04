Rails.application.routes.draw do
  root "main#index"

  # Маршруты для пользователей
  resources :users, only: [ :show, :new, :create ]
  get "/signup", to: "users#new", as: :signup  # Добавляем этот маршрут
  get "/help", to: "main#help", as: :help

  # Маршруты для сессий
  resources :sessions, only: [ :new, :create, :destroy ]
  get "/signin", to: "sessions#new", as: :signin
  post "/signin",  to: "sessions#create"
  delete "/signout", to: "sessions#destroy", as: :signout
  # get "/signout", to: "sessions#destroy" # Временно!

  # Остальные ресурсы
  resources :themes, :values, :images

  # WorkController
  get "work", to: "work#index"
  post "display_theme", to: "work#display_theme"
  get "image/:image_id", to: "work#show_image", as: :show_image

  # API
  namespace :api do
    get "next_image", to: "api#next_image"
    get "prev_image", to: "api#prev_image"
  end

  # MainController
  get "help", to: "main#help"
  get "contacts", to: "main#contacts"
  get "about", to: "main#about"
end
