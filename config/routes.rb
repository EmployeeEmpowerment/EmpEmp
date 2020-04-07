Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  
  resources :companies
  
  root 'welcome#index'
end
