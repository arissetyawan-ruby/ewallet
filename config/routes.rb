Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  devise_for :accounts, controllers: {
  	sessions: 'accounts/sessions'
  }

	get '/dashboard', to: 'dashboard#index', as: 'dashboard'

end