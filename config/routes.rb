Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :users, only: [:new, :create]
  resources :items, only: [:new, :create, :show, :edit, :update, :destroy] do
# 購入に関連するルートを追加
    resources :purchase_shipping, only: [:index, :new, :create], controller: 'purchase_shipping'
    resources :purchase_records, only: [:index, :new, :create]
  end
  end