Rails.application.routes.draw do
	root 'pages#home'
	
	get 'pages/home'

	get 'pages/about_us'

	get 'pages/contact_us'

	devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    devise_scope :user do
	  root to: "devise/sessions#new"
	end
    resources :users, only: [:index,:show]
    resources :chat_rooms, only: [:new, :create, :show, :index]
    mount ActionCable.server => '/cable'
    resources :messages
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
	get 'messages/index' => 'chat_rooms#index'
	get 'application/messages' => 'application#messages'
	#resources :friendships
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
