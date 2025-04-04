Rails.application.routes.draw do
  root "main#index"

  # Стандартные ресурсы
  resources :themes, :values, :images, :users

  # Маршруты для показа изображений
  get "images/:image_id", to: "images#show_image", as: :image_picture

  # Кастомные маршруты для WorkController
  get "work", to: "work#index", as: :work
  post "display_theme", to: "work#display_theme"
  get "image/:image_id", to: "work#show_image", as: :show_image

  # Маршруты MainController
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"

  # API namespace
  namespace :api, module: "api", path: "api" do
    get "next_image", to: "api#next_image"
    get "prev_image", to: "api#prev_image"
  end
end
