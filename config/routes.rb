Rails.application.routes.draw do
  get 'tops/show'

  devise_for :users

  resources :items, only: %i(new create edit update index show) do
    member do
      patch :stock
      patch :unstock
    end

    post :preview, on: :collection

    resources :comments, only: %i(create)
  end

  resources :tags, only: %i(show)
  resources :users, only: %i(show)

  root 'tops#show'
end
