Rails.application.routes.draw do
  root "main#index"

  # Стандартные ресурсы
  resources :themes, :values, :images, :users

  # Кастомные маршруты для WorkController
  get "work", to: "work#index", as: :work
  post "display_theme", to: "work#display_theme"
  get "image/:image_id", to: "work#show_image", as: :show_image

  # Маршруты MainController
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"
end

# Rails.application.routes.draw do
#   root "work#index"

#   get "work", to: "work#index"
#   post "display_theme", to: "work#display_theme"
#   get "image/:image_id", to: "work#show_image", as: "show_image"
# end
