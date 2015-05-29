Rails.application.routes.draw do
  get 'tops/show'

  devise_for :users

  root 'tops#show'
end
