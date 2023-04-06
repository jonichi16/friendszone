Rails.application.routes.draw do
  authenticated :user do
    root to: "posts#index", as: :authenticated_root
  end
  root to: redirect("/users/sign_in")

  devise_for :users

  resources :users, only: %i[index show] do
    resources :friends, only: %i[index]
  end
  resources :posts, only: %i[create] do
    resources :comments, only: %i[index new create]
  end
  resources :notifications, only: %i[index]
  resources :friends, only: %i[create update destroy]
  get "/update_notif/:id", to: "notifications#update_notif", as: :update_notif
end
