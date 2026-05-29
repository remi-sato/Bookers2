Rails.application.routes.draw do
  get "relationships/followings"
  get "relationships/followers"
  get "create/destroy"
  get "favorites/create"
  get "favorites/destroy"
  get "/users/sign_in", to: "sessions#new", as: :sign_in
  resources :users, only: [:new, :create, :edit, :update, :index, :show],path_names:{ new:"sign_up"} do
   resource :relationships, only: [:create, :destroy]
   get "followings" => "relationships#followings", as: "followings"
   get "followers" => "relationships#followers", as: "followers"
  end
  resource :session
  resources :passwords, param: :token
  resources :books,only: [:index, :create, :show, :edit, :destroy, :update]
  resources :books do
   resource :favorite, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  root to: "homes#top"
  get "/home/about",to:"homes#about",as: "home_about"
  get "/search" => "searches#search"

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
