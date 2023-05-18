Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      # Users
      get '/users', to: 'users#index'
      get '/users/:id', to: 'users#show'
      post '/users/add', to: 'users#create'
      delete '/users/delete/:id', to: 'users#destroy'
      patch '/users/update/:id', to: 'users#update'
      post '/users/login', to: 'authentication#login'

      # Products
      get '/products', to: 'products#index' do
        get :image, on: :member 
      end
      get '/products/:id', to: 'products#show' do
        get :image, on: :member 
      end
      post '/products/add', to: 'products#create'
      delete '/products/delete/:id', to: 'products#destroy'
      patch '/products/update/:id', to: 'products#update'
      get '/products/categories', to: 'products#categories' # New route for categories
    end
  end
end
