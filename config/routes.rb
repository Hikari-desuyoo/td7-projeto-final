Rails.application.routes.draw do
  #BASIC
  root 'home#index'
  patch 'complete_profile', to: 'workers#complete_profile'
  get 'search', to: 'search#search'

  #DEVISE
  devise_for :workers 
  devise_for :hirers, :controllers => { registrations: 'hirers/registrations' }

  #RESOURCES
  resources :hirers, only: [:show] do
    resources(
      :hirer_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end

  resources :workers, only: [:show, :edit, :update] do
    resources(
      :worker_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end

  resources :projects, only: [:new, :create, :show] do
    resources :project_applications, only: [:create], shallow: true do
      post 'accept', on: :member
      post 'decline', on: :member
    end
    resources(
      :project_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end
end
