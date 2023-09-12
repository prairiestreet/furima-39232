Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: [:new, :create]
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :purchase_records, only: [:index, :new, :create]
  end
  get 'items/new', to: 'items#new' 
end