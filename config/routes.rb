Rails.application.routes.draw do
  get 'tops/show'

  resources :items, only: %i(index)

  devise_for :users

  root 'tops#show'
end
