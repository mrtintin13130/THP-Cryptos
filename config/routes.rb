Rails.application.routes.draw do
  resources :crypto, only: [:index, :create]
  root 'crypto#index'
  post '/', to: 'crypto#show'
  get '/show/:id', to: 'crypto#display'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
