Rails.application.routes.draw do
	root 'pages#home'
	
	get 'pages/home'

	get 'pages/about_us'

	get 'pages/contact_us'

	devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
    devise_scope :user do
	  root to: "devise/sessions#new"
	end
    resources :users, only: [:index,:show, :update]
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
	post 'decline'=> 'users#decline_friend'
	post 'accept'=> 'users#accept_friend'
	post 'remove'=> 'users#remove_friend'
	get 'messages/index' => 'chat_rooms#index'
	get 'application/messages' => 'application#messages'
	post 'follow_organization' => 'organizations#follow'
	post 'post_like' => 'posts#post_like'
	post 'follow_unfollow' => 'users#follow_unfollow'
	post 'like_organization' => 'organizations#like_unlike'
	post 'like_fundraise' => 'fundraises#like'
	post 'follow_fundraise' => 'fundraises#follow'
	post 'like_campaign' => 'campaigns#like'
	post 'follow_campaign' => 'campaigns#follow'
	post 'like_cause' => 'causes#like'
	post 'follow_cause' => 'causes#follow'
	post 'organization_invitation' => 'organizations#organization_invitation'
	post 'accept_organization' => 'organizations#accept_organization'
	get  'organization_friend' => 'organizations#friend'
	post 'organization_invite' => 'organizations#organization_invite'
	#resources :friendships
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
