Rails.application.routes.draw do
  root 'home#index'

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons, only: %i[index show new create edit update]
    end
  end
end
