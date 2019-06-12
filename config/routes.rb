Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :update]
    end
  end

  get '/account', to: 'homes#index'
  get '/api/v1/current_user', to: 'current_users#get_current_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
