Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end

  #API
  namespace :api do
    namespace :v1 do
      jsonapi_resources :movies
    end
    namespace :v2 do
      jsonapi_resources :movies
    end
  end
end
