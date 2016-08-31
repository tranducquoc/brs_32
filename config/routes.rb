Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :books
  resources :users
  resources :likes, only: [:create, :edit]
end
