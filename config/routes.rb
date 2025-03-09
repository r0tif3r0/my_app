Rails.application.routes.draw do
  resources :users
  root "main#index"
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"
end
