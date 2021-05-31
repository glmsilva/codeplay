Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :instructors
    resources :courses do
      resources :lessons
      get 'search', on: :collection
    end
  end

  resources :courses, only: %i[index show] do
    post 'enroll', on: :member
    get 'search', on: :collection
    get 'my_courses', on: :collection
  end
end
