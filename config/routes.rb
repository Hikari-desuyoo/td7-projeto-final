Rails.application.routes.draw do
  devise_for :workers 
  devise_for :hirers

  resources :hirers, only: [:show]
  resources :workers, only: [:show, :edit, :update] 
  patch 'complete_profile', to: 'workers#complete_profile'
  get 'search', to: 'search#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :projects, only: [:new, :create, :show] do
    resources :project_applications, only: [:create]
  end
end
