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

  match '/about/coc' => 'about#coc', via: [:get]
  match '/about/privacy_policy' => 'about#privacy_policy', via: [:get]
  match '/about/tos' => 'about#tos', via: [:get]

  root 'welcome#index'
end
