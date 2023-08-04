Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "activities#index"

  resources :activities, only: [:new, :index, :create, :show, :edit] do
    resources :participants, only: [:new, :create]
    resources :expenses, only: [:new, :create, :edit, :update]
  end
end
