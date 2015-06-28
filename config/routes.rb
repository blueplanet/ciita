Rails.application.routes.draw do
  resources :items, excpet: %i(destroy) do
    member do
      patch :stock
      patch :unstock
    end

    post :preview, on: :collection

    resources :comments, only: %i(create)
  end

  concern :followable do
    member do
      patch :follow
      patch :unfollow
    end
  end

  resources :tags, only: %i(show), concerns: :followable
  resources :users, only: %i(show), concerns: :followable do
    get :items
    get :stocks
    get :comments
  end

  devise_for :user

  root 'tops#show'
end
