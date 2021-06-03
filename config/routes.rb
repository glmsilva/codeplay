Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :instructors do
      get 'show_inactive', on: :collection
      post 'active_instructor', on: :member
      post 'inactive_instructor', on: :member
    end
    resources :courses do
      resources :lessons
      get 'search', on: :collection
    end
  end

  resources :courses, only: %i[index show] do
    resources :lessons, only: %i[index show] do
      post 'attend_lesson', on: :member
    end

    post 'enroll', on: :member
    get 'search', on: :collection
    get 'my_courses', on: :collection
  end


end
