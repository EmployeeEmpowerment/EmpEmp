# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'

  resources :companies

  resources :users
  resources :jobs

  root 'welcome#index'
end
