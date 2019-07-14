Rails.application.routes.draw do
  devise_for :users
  get 'products/index'
  get 'products/show'
  root 'products#index'
  resources :products, only: [:index, :show]
  # resources :carts, only: %i[show destroy]
  resources :cart_items, only: %i[create destroy] do
    collection do
      patch '/update_quantity', action: :update_quantity
    end
  end

  namespace :admin do
    root 'products#index'
    resources :products, only: [:new, :create, :index, :edit, :update, :destroy]
  end

  resource :carts, only: [:show] do
    post ':product_id', to: 'carts#add_item', as: :add_item
    delete ':product_id', to: 'carts#remove_item', as: :remove_item
  end
end
