Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  root "static_pages#home"
  resources :books
  resources :users
  resources :likes, only: [:create, :edit]
  resources :requests, only: [:new, :create]
  namespace :admin do
    root "books#index"
    resources :books
    resources :requests, only: [:index, :update]
  end
  resources :user_books
  resources :comments
end
