oauth_provider = OAuthProvider.new

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[ new ]
  # get "sign_up", action: :new, controller: "users", as: :sign_up
  resources :sessions, only: %i[ new ]
  # get "sign_in", action: :new, controller: "sessions", as: :sign_in

  namespace :provider do
    resources :authorizations, only: %i[ create show ]
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  match "/provider/*phase", to: oauth_provider, via: :all

  # Defines the root path route ("/")
  # root "posts#index"
end
