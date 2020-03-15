Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :user do
      root "homes#index"
      devise_for :accounts
    end

    namespace :admin do
      root "home#index"

      resources :companies
    end
  end
end
