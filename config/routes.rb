Rails.application.routes.draw do
  
  # devise_scope :user do
  #   post '/users/sign_up', to: 'devise/registrations#new'
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  #root "zoos#index"


  # resources :users
  # post '/auth/login', to: 'authentication#login'

  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  

  namespace :api do
    namespace :v1 do
      resources :zoos do
        resources :animals 
      end 
    end
  end
end

 