Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check



  # 一般ユーザー向けのルート
  resources :movies do
    member do
      get 'reservation'
    end
    resources :schedules do
      resources :reservations
    end
    get 'reservation'
  end


  # 管理者向けのルート
  namespace :admin do
    get 'schedules/index'
    resources :movies do
        resources :schedules
        resources :reservations
    end
    resources :schedules
    resources :reservations
  end

  resources :sheets

  resources :reservations

# , only: [:new, :create]
  # Defines the root path route ("/")
  # root "posts#index"
end
