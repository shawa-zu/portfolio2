Rails.application.routes.draw do
  get '/about',   to: 'static_pages#about',   as: :about
  get '/terms',   to: 'static_pages#terms',   as: :terms
  get '/privacy', to: 'static_pages#privacy', as: :privacy
  
  resources :lineups, only: [ :index, :show, :new, :create, :edit, :update, :destroy ]
  resources :players, only: [ :index, :new, :create, :edit, :update, :destroy ]
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
