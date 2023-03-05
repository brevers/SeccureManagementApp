Rails.application.routes.draw do
  resources :projects
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "project#index"

  # Defines the root path route ("/")
  # root "articles#index"
end
