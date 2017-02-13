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

        resources :cards, only: [:index, :create, :destroy] do

        end


      end
    end
  end

end
