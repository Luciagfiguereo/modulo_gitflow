require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :companies
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  #resources :notifications, only: [:index]
  #resources :announcements, only: [:index]
  # devise_for :users, controllers: { 
  #   omniauth_callbacks: "users/omniauth_callbacks",
  #   registrations:      'users/registrations' 
  # }
  root to: 'companies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
