Rails.application.routes.draw do
  devise_for :workers 
  devise_for :hirers

  resources :hirers, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :projects, only: [:new, :create, :show]
end
