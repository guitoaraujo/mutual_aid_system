Rails.application.routes.draw do

  resources :testes
  namespace :panel do
    get 'welcome/index'
    resources :orders
    resources :users, only: [:index, :create]
	  post 'validation', to: 'orders#validate_order', as: 'validation'
  end

  get 'welcome/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
	
	root 'welcome#index'
end
