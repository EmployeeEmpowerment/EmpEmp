Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :companies
  
  root 'welcome#index'
end
