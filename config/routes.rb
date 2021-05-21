Rails.application.routes.draw do
    root "home#index"
    resources :courses 
    resources :instructors, only: %i[index show]
end
