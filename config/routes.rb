Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/services/update_availability', to: 'services#update_availability'
      get '/services/update_all_availabilities', to: 'services#update_all_availabilities'
      resources :services
      resources :movies
    end
  end
end
