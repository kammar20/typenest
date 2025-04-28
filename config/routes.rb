Rails.application.routes.draw do
  root "pages#home"

  resources :blogs do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  

  get "/signup", to: "users#new"
  resources :users, except: [:new]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
