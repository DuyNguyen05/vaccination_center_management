Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :user do
      root "homes#index"
      devise_for :accounts
      resources :injection_books
      resources :info_injection_books, except: [:index]
      resources :accounts, only: [:show]
      resources :details_infos, only: [:new, :create]
    end

    namespace :admin do
      root "home#index"

      resources :companies
      resources :accounts
      resources :details_infos, only: [:new, :create]
    end
  end
end
