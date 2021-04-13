Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      patch '/services/update_availability', to: 'services#update_availability'
      patch '/services/update_all_availabilities', to: 'services#update_all_availabilities'
      resources :services
      resources :movies
    end
  end
end
