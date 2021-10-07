Rails.application.routes.draw do
  devise_for :hirers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
