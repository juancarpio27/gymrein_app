Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#welcome'

  namespace :api do
    namespace :v1 do
      constraints(format: 'json') do

        resource :users, only: [:create, :update]

        resource :sessions, only: [:destroy] do
          collection {
            post 'plain'
          }
        end

        resource :api_keys, only: [] do
          collection {
            post 'validate'
          }
        end

        resources :cards, only: [:index, :create, :destroy] do

        end

        resources :packages, only: [:index, :show] do

        end

        resources :promotions, only: [] do
          collection {
            post 'validate'
          }
        end

      end
    end
  end

  namespace :admin do
    get "log_out" => "sessions#destroy", :as => "log_out"
    get "log_in" => "sessions#new", :as => "log_in"
    get "sign_up" => "users#new", :as => "sign_up"

    root 'menu#index'

    resources :admins
    resources :sessions
    resources :users
    resources :instructors
    resources :locations
    resources :events
    resources :packages
    resources :promotions
  end

end
