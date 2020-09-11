Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items do
    resources :purchase_orders, only: [:index, :create]
  end
end
