Rails.application.routes.draw do



  # namespace :developers do
    # root to: 'pages#index'
  # end




  require 'sidekiq/web'


  # match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  devise_for :admin_users, path: 'admin'
  devise_for :drivers, path: 'driver' ,:controllers => { :sessions => "drivers/sessions", registrations: "drivers/registrations" }

  get "/drivers" => redirect('driver')
  get "/drivers/sign_in" => redirect('driver')
  get "drivers/sign_up" => redirect('driver')

  get "/admin_users" => redirect('admin')
  get "admin_users/sign_in" => redirect('admin')


  namespace :api, :defaults => {:format => 'json'} do
    namespace :v1 do

      namespace :b2b do
        resources :sessions do
          post 'check', on: :collection
        end

        resources :users do
          post 'login', on: :collection
          post 'logout', on: :collection
          post 'change_password', on: :collection
        end
        resources :deliveries
        resources :promocodes
        resources :drivers
        resources :vehicle_types

      end

      namespace :driver do
        resources :sessions do
          post 'check', on: :collection
        end

        resources :drivers do
          post 'login', on: :collection
          post 'logout', on: :collection

          post 'update_location', on: :collection
          post 'change_password', on: :collection
          get 'earnings', on: :collection
          get 'remove_availability', on: :collection
        end
        resources :deliveries do
          post 'changeStatus', on: :collection
          post 'changeDeliveryStatus', on: :collection
          get 'testPush', on: :collection
        end
      end
    end
  end

  namespace :admin do

    root to: 'dashboard#index'
    resources :dashboard
    resources :users do
      collection do
        get 'report'
        get 'deactive'
      end
    end
    resources :drivers do
      collection do
        get 'pending_list'
        get 'suspend_list'
        get 'verify'
        get 'report'
        get 'verified'
        get 'map'

      end

      member do

        end
    end
    resources :vehicles
    resources :offers
    resources :deliveries do
      collection do
        get 'later'
        get 'completed'
        get 'abendand'
      end
      member do
        get 'allocation'
        get 'cancel'
      end
    end

    resources 'reports', only: [:index] do
      collection do
        get "daily_deliveries"
        post "daily_deliveries"
      end
    end

    resources :admin_notifications

  end

  resources :driver do
    collection do
      get 'personal_info'
      post 'personal_info'
      get 'employment_info'
      post 'employment_info'
      get 'health'
      post 'health'
      get 'rehabilitation'
      post 'rehabilitation'
      get 'verification'
      post 'verification'
      get 'driving_license'
      post 'driving_license'
      get 'references'
      post 'references'
      get 'supporting_documents'
      post 'supporting_documents'
      get 'declaration_consent'
      post 'declaration_consent'
      get 'equal_opportunities'
      post 'equal_opportunities'
      get 'confirmation'
      post 'confirmation'

      get 'terms'
    end
  end


  #resources :notifications


  root to: 'driver#index'

  mount Sidekiq::Web => '/sidekiq'

end
