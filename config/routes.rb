Rails.application.routes.draw do
  root to: 'home#show'

  resources :logs
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/status', to: 'status#index'
end
