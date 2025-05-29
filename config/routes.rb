Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :moodtrackers, only: %i[new create index show edit update]
  resources :suggestions, only: %i[new create index update] do
    resource :suggestions_comments, only: %i[create]
    resource :likes, only: %i[create]
  end
  resources :events
  resources :teams, only: [:index, :show]
  resources :pages, only: %i[dashboard]
end
