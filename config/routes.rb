Rails.application.routes.draw do
  root to: "homes#top"

  resources :users, only: [:index, :show, :create, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    delete :followers, on: :member
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  get "signup" => "users#new"

  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get "chat/:id", to: "chats#show", as: "chat"
  resources :chats, only: [:create, :show]

  resources :notifications, only: [:index, :destroy]
end
