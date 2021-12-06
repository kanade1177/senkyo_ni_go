Rails.application.routes.draw do
  
  
  root to: "homes#top"
  
  resources :users, only: [:index, :show, :create, :edit, :update]
  
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  
  get "signup" => "users#new"
  
end
