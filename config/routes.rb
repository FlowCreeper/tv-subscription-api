Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # API Routes
  namespace :api do
    # Registering Routes
    resources :customers
    resources :plans
    resources :adicional_services
    resources :packages

    # Subscription Route
    resources :subscriptions

    # Invoice PDF Route
    resources :invoices, only: [ :show ]
    resources :booklets, only: [ :show ]
  end
end
