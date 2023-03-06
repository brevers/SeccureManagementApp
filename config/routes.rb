Rails.application.routes.draw do
  root to: "projects#index"

  devise_for :users

  resources :projects do
    resources :tasks
  end

  namespace :admin do
    resources :dashboard, only: [:index] do
    end

    resources :users, only: [:index, :update] do
    end
  end
end
