Rails.application.routes.draw do
  get 'stocks/index'

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

  resources :tags, only: %i(show) do
    member do
      patch :follow
      patch :unfollow
    end
  end

  resources :users, only: %i(show) do
    resources :stocks, only: %i(index)

    member do
      patch :follow
      patch :unfollow
    end
  end

  root 'tops#show'
end
