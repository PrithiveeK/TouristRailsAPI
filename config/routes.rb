Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    post 'users/login', to: 'authentication#login'
    get 'users/access', to: 'authentication#get_access'
    resources :users
    resources :company do
      resources :branch
      resources :staff
      resources :tc
    end
    namespace :master_data do
      resources :continents
      resources :countries
      resources :cities
      resources :languages
      resources :markets
      resources :regions
      resources :styles
      resources :hotdate_difficulty
      resources :hotdates
      resources :nationalities
      resources :location_types
      resources :location2_types
      resources :service_types
      resources :supplier_types
      resources :charge_types
      resources :person_types
      resources :room_types
      resources :rating_types
      resources :category_types
      resources :category2_types
      resources :amenities
      resources :facilities
      resources :addons
      resources :remarks
      resources :terms_and_conditions
      resources :company_types
      resources :departments
      resources :currencies
      resources :currencies2
      resources :roles
      resources :document_types
      resources :group_pax_slab_types
      resources :tour_pattern_types
      resources :tour_pattern2_types
      resources :coach_size_types
      resources :menu_types
      resources :breakfast_types
      resources :tickets
      resources :class_types
      resources :master_chains
      resources :chains
      resources :titles
    end
  end
  get '/*a', to: 'application#not_found'
  post '/*a', to: 'application#not_found'
  delete '/*a', to: 'application#not_found'
  put '/*a', to: 'application#not_found'
end
