Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  root 'products#index'
  resources :products, only: [:index, :show]
  resources :carts, only: %i[show destroy]
  resources :cart_items, only: %i[create destroy] do
    collection do
      patch '/update_quantity', action: :update_quantity
    end
  end
end
