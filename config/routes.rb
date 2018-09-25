Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  devise_for :accounts, controllers: {
  	sessions: 'accounts/sessions', registrations: 'accounts/registrations'
  }

	get '/dashboard', to: 'dashboard#index', as: 'dashboard'

	resources :transactions

	get '/registrations', to: 'home#registration', as: 'registration_board'
end
