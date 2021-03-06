Rails.application.routes.draw do
  resources :items, except: %i(destroy) do
    member do
      patch :stock
      patch :unstock
    end

    collection do
      post :preview
      get :all
    end

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
