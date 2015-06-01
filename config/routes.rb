Rails.application.routes.draw do
  get 'tops/show'

  resources :items, only: %i(new create index show)
  resources :tags, only: %i(show)
  resources :users, only: %i(show)

  devise_for :users

  root 'tops#show'
end
