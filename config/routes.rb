Rails.application.routes.draw do
  root to: 'ui#index'

  get 'ui', to: 'ui#index'
  get 'ui/:action', controller: 'ui'
  get '/testing_api', to: 'apis#testing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/home', to: 'landing_pages#home'

  resources :users, only: [:new, :create]
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
end
