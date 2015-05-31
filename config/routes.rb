Rails.application.routes.draw do
  get 'tops/show'

  resources :items, only: %i(index show)
  resources :tags, only: %i(show)

  devise_for :users

  root 'tops#show'
end
