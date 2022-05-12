Rails.application.routes.draw do
  resources :categories
  resources :products_ordereds
  resources :orders
  resources :customers
  resources :products

  get 'products_and_category', to: 'categories#products_and_category'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
