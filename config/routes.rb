Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :user do
      root "homes#index"
      devise_for :accounts
      resources :injection_books
      resources :info_injection_books
      resources :accounts, only: [:show]
      resources :details_infos, only: [:new, :create]
      resources :detail_injection_books
    end
    root "homes#index"

    namespace :admin do
      root "home#index"

      devise_for :admins, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

      resources :accounts
      resources :companies
      resources :details_infos
      resources :import_vaccines
      resources :vaccines
      resources :vaccine_package_types
      resources :departments
    end
  end
end
