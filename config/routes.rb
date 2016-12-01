Rails.application.routes.draw do
	root 'pages#home'
	
	get 'pages/home'

	get 'pages/about_us'

	get 'pages/contact_us'

	devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

	resources :posts
	resources :campaigns
	resources :causes
	resources :comments
	resources :fundraises
	resources :jobs
	resources :organizations
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
