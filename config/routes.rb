Rails.application.routes.draw do
  root 'home#index'
  resources :courses do
    resources :lessons, only: [:index]
  end
  resources :instructors
end
