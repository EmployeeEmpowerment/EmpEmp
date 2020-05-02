# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :companies

  resources :users do
    resources :jobs
  end

  root 'welcome#index'
end
