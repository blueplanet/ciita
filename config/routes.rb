Rails.application.routes.draw do
  get 'tops/show'

  devise_for :users

  resources :items, only: %i(new create edit update index show) do
    resources :comments, only: %i(create)
    post :preview, on: :collection
  end

  resources :tags, only: %i(show)
  resources :users, only: %i(show)

  root 'tops#show'
end
