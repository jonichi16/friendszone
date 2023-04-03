Rails.application.routes.draw do
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end
  root to: redirect("/users/sign_in")

  devise_for :users

  resources :users, only: %i[index show] do
    resources :friends, only: %i[index]
  end
  resources :notifications, only: %i[index]
  resources :friends, only: %i[create update destroy]
  get "/update_notif/:id", to: "notifications#update_notif", as: :update_notif
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
