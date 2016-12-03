Rails.application.routes.draw do
	root 'pages#home'
	
	get 'pages/home'

	get 'pages/about_us'

	get 'pages/contact_us'

	devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    resources :users, only: [:index]
    
	resources :posts
	resources :campaigns
	resources :causes
	resources :comments
	resources :fundraises
	resources :jobs
	resources :organizations
	post 'invite'=> 'users#invite_friend'
	post 'accept'=> 'users#accept_friend'
	post 'remove'=> 'users#remove_friend'
	#resources :friendships
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
