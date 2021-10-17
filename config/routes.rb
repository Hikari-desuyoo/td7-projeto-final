Rails.application.routes.draw do
  #BASIC
  root 'home#index'
  patch 'complete_profile', to: 'workers#complete_profile'
  get 'search', to: 'search#search'

  #DEVISE
  devise_for :workers, :controllers => { 
    registrations: 'workers/registrations',
    sessions: 'workers/sessions'
  }
  
  devise_for :hirers, :controllers => { 
    registrations: 'hirers/registrations',
    sessions: 'hirers/sessions'
  }

  #RESOURCES
  resources :hirers, only: [:show] do
    resources :favorited_workers, only: [], shallow: true do
      post 'favorite', on: :member
      delete 'unfavorite', on: :member
    end
    resources(
      :hirer_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end

  resources :workers, only: [:show, :edit, :update] do
    resources :favorited_hirers, only: [], shallow: true do
      post 'favorite', on: :member
      delete 'unfavorite', on: :member
    end

    resources(
      :worker_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end

  resources :project_applications, only: [:show] do
    get 'my_project_applications', on: :collection
  end

  resources :projects, only: [:new, :create, :show], shallow: true do
    post 'finish', on: :member
    post 'close', on: :member
    get 'my_projects', on: :collection
  
    resources :project_applications, only: [:create], shallow: true do
      post 'accept', on: :member
      post 'decline', on: :member
      delete 'cancel', on: :member
    end
    resources(
      :project_feedbacks, 
      :path => :feedbacks, 
      :as => :feedbacks, 
      only: [:new, :create, :update]
    )
  end
end
