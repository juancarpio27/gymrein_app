Rails.application.routes.draw do

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#welcome'

  namespace :api do
    namespace :v1 do
      constraints(format: 'json') do

        resource :users, only: [:create, :update, :show] do
          collection {
            post 'validate'
            post 'send_password_recovery'
          }
        end

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

        resources :cards, only: [:index, :create, :destroy]
        resources :packages, only: [:index, :show]
        resources :instructors, only: [:show]
        resources :events, only: [:show]
        resources :locations, only: [:show]

        resources :user_packages, only: [:create, :index]
        resources :class_dates, only: [:show] do
          collection {
            post 'find_by_date'
          }
        end

        resources :promotions, only: [] do
          collection {
            post 'validate'
          }
        end

        resources :reservations, only: [:create, :destroy] do
          collection {
            post 'find_by_date'
            get 'future'
          }
          member do
            post 'check_in'
          end
        end
        resources :waiting_lists, only: [:create, :index, :show, :destroy] do
          collection {
            get 'future'
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
    resources :events do
      resources :class_dates do
        resources :reservations, only: [:index]
        resources :waiting_lists, only: [:index]
      end
    end
    resources :packages
    resources :promotions
  end

end
