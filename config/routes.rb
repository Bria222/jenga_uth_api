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
      
      # categories
      get '/categories', to: 'categories#index'
      get '/categories/:id', to: 'categories#show'
      post '/categories/add', to: 'categories#create'
      delete '/categories/delete/:id', to: 'categories#destroy'
      patch '/categories/update/:id', to: 'categories#update'
    end
  end
end
