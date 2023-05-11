Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  

  resources :vehicles
  
 
  devise_scope :user do
    get '/users', to: 'users/registrations#show', as: :user_profile
    delete '/users', to: 'users/registrations#destroy'
  end
  put '/user_images', to: 'user_images#update'
  get '/user_images', to: 'user_images#show'

  resources :publishes do
    resources :passengers, only: [:create, :destroy]
  end
  
  post '/search', to: 'searches#search'




  resources :account_activations, only: [:edit,:create]
  
end
