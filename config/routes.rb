Rails.application.routes.draw do
  resources :comments
  resources :episodes
  resources :shows
  resources :content_providers
  devise_for :users
  root to: "home#index"
end
