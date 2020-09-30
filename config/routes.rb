Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    post 'users/login', to: 'authentication#login'
    get 'users/access', to: 'authentication#get_access'
    resources :users, only: [:index, :create]
    resources :company do
      resources :branch, only: [:index, :create]
      resources :staff, only: [:index, :create]
      resources :tc, only: [:index, :create]
    end
    namespace :master_data do
      resources :continents, only: [:index, :create, :update, :destroy]
      resources :countries, only: [:index, :create, :update, :destroy]
      resources :cities, only: [:index, :create, :update, :destroy]
      resources :languages, only: [:index, :create, :update, :destroy]
      resources :markets, only: [:index, :create, :update, :destroy]
      resources :regions, only: [:index, :create, :update, :destroy]
      resources :styles, only: [:index, :create, :update, :destroy]
      resources :hotdate_difficulty, only: [:index, :create, :update, :destroy]
      resources :hotdates, only: [:index, :create, :update, :destroy]
      resources :nationalities, only: [:index, :create, :update, :destroy]
      resources :location_types, only: [:index, :create, :update, :destroy]
      resources :location2_types, only: [:index, :create, :update, :destroy]
      resources :service_types, only: [:index, :create, :update, :destroy]
      resources :supplier_types, only: [:index, :create, :update, :destroy]
      resources :charge_types, only: [:index, :create, :update, :destroy]
      resources :person_types, only: [:index, :create, :update, :destroy]
      resources :room_types, only: [:index, :create, :update, :destroy]
      resources :rating_types, only: [:index, :create, :update, :destroy]
      resources :category_types, only: [:index, :create, :update, :destroy]
      resources :category2_types, only: [:index, :create, :update, :destroy]
      resources :amenities, only: [:index, :create, :update, :destroy]
      resources :facilities, only: [:index, :create, :update, :destroy]
      resources :addons, only: [:index, :create, :update, :destroy]
      resources :remarks, only: [:index, :create, :update, :destroy]
      resources :terms_and_conditions, only: [:index, :create, :update, :destroy]
      resources :company_types, only: [:index, :create, :update, :destroy]
      resources :departments, only: [:index, :create, :update, :destroy]
      resources :currencies, only: [:index, :create, :update, :destroy]
      resources :currencies2, only: [:index, :create, :update, :destroy]
      resources :roles, only: [:index, :create, :update, :destroy]
      resources :document_types, only: [:index, :create, :update, :destroy]
      resources :group_pax_slab_types, only: [:index, :create, :update, :destroy]
      resources :tour_pattern_types, only: [:index, :create, :update, :destroy]
      resources :tour_pattern2_types, only: [:index, :create, :update, :destroy]
      resources :coach_size_types, only: [:index, :create, :update, :destroy]
      resources :menu_types, only: [:index, :create, :update, :destroy]
      resources :breakfast_types, only: [:index, :create, :update, :destroy]
      resources :tickets, only: [:index, :create, :update, :destroy]
      resources :class_types, only: [:index, :create, :update, :destroy]
      resources :master_chains, only: [:index, :create, :update, :destroy]
      resources :chains, only: [:index, :create, :update, :destroy]
      resources :titles, only: [:index, :create, :update, :destroy]
    end
  end
  get '/*a', to: 'application#not_found'
  post '/*a', to: 'application#not_found'
  delete '/*a', to: 'application#not_found'
  put '/*a', to: 'application#not_found'
end
