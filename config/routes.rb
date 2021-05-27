Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons
    end
  end

  resources :courses, only: %i[index show]
end
