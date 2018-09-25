Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  devise_for :users, controllers: {
  	sessions: 'users/sessions', registrations: 'users/registrations'
  }

	get '/dashboard', to: 'dashboard#index', as: 'dashboard'

	resources :transactions do
		collection do
			post :top_up
			get :withdraw
			post :withdraw
		end

	end

	get '/registrations', to: 'home#registration', as: 'registration_board'
end
