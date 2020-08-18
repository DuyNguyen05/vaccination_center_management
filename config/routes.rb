# require 'sidekiq/web'
Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :user do
      mount ActionCable.server => '/cable'
      # mount Sidekiq::Web => '/sidekiq'
      root "homes#index"
      devise_for :accounts
      resources :injection_books
      resources :info_injection_books
      resources :accounts
      resources :details_infos, only: [:new, :create]
      resources :detail_injection_books
      resources :vaccines, only: :index
      resources :injection_schedules
      resources :vaccine_package_types, only: :index
      resources :provinces, only: :index
      resources :districts, only: :index
      resources :wards, only: :index
      resources :wait_numbers
      resources :bills
      get "/export_bill", to: "bills#export_bill"
      get "/schedule", to: "injection_schedules#schedule"
      resources :appointments
      resources :notifis, only: [:index, :update]
    end
    root "homes#index"
    resources :injection_schedules, only: :index
    resources :info_injection_books
    get "/vaccine-price", to: "homes#vaccine_price"
    get "/about", to: "homes#about"
    get "/schedule", to: "injection_schedules#schedule"

    namespace :admin do
      root "home#index"

      devise_for :admins, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

      resources :accounts
      resources :info_injection_books
      resources :companies
      resources :details_infos
      resources :import_vaccines
      resources :vaccines
      resources :departments
      resources :vaccine_package_types do
        resources :detail_vaccine_packages, shallow: true
      end
    end
  end
end
