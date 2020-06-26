# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'welcome/index'

  resources :companies do
    resources :executives
    resources :employee_ratings
  end

  resources :users
  resources :jobs

  root 'welcome#index'
end
