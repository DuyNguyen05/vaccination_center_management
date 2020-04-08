Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :user do
      root "homes#index"
      devise_for :accounts
      resources :injection_books
      resources :info_injection_books, except: [:index]
      resources :accounts, only: [:show]
      resources :details_infos, only: [:new, :create]
      resources :injections, only: [:index]
    end

    namespace :admin do
      root "home#index"

      resources :accounts
      resources :companies
      resources :details_infos

      devise_for :admins, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}
    end
  end
end
