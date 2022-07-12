Rails.application.routes.draw do
  resources :categories
  resources :products_ordereds
  resources :customers
  resources :products

  resources :orders do
    get 'index_by_status', on: :collection
    get 'create_pdf', on: :collection
  end

  resources :authentications do
    post 'post_otp', on: :collection
    post 'request_otp', on: :collection
    post 'google_login', on: :collection
    post 'password_login', on: :collection
    post 'firebase_otp_verification', on: :collection
  end

  get 'products_and_category', to: 'categories#products_and_category'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
