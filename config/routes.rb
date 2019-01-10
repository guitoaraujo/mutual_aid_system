Rails.application.routes.draw do

  resources :testes
  namespace :panel do
    get 'cicles/index'
    get 'cicles/renew'
    resources :orders,    only: [:index, :new, :create, :destroy]
    resources :withdraws, only: [:index, :new, :create, :destroy]
    resources :users,     only: [:new, :create]
	  
    post 'validation', to: 'orders#validate_order', as: 'validation'
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
	
  get 'welcome/faq'
	root 'welcome#index'
end
