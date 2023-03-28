Rails.application.routes.draw do
  root to: "projects#index"

  devise_for :users

  resources :projects do
    resources :tasks
  end

  resources :two_factors, only: [:create, :destroy]

  namespace :admin do
    resources :dashboard, only: [:index] do
    end

    resources :users, only: [:index, :update] do
    end
  end
end
