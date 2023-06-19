Rails.application.routes.draw do
 
  resources :posts
  root to: "home#index"
  devise_for :users
  resources :users
end
