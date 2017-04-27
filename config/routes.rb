Rails.application.routes.draw do
  root to: 'ui#index'

  get 'ui', to: 'ui#index'
  get 'ui/:action', controller: 'ui'
  get '/testing_api', to: 'apis#testing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
