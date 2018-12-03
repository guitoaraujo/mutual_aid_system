Rails.application.routes.draw do

  resources :testes
  namespace :panel do
    get 'welcome/index'
    resources :orders
  end

  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
	
	root 'welcome#index'
end
