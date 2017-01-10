Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
    #mount ActionCable.server => '/cable'
    resources :messages
	resources :posts
	resources :campaigns
	resources :causes
	resources :comments
	resources :fundraises
	resources :jobs
	resources :payments
	resources :organizations
	resources :fundraise_payment_details
	post 'invite'=> 'users#invite_friend'
	post 'decline'=> 'users#decline_friend'
	post 'accept'=> 'users#accept_friend'
	post 'remove'=> 'users#remove_friend'
	get 'edit_user'=> 'users#edit'
	get 'messages/index' => 'chat_rooms#index'
	get 'application/messages' => 'application#messages'
	put 'follow_organization' => 'organizations#follow'
	put 'like_post' => 'posts#post_like'
	put 'follow_user' => 'users#follow_unfollow'
	put 'like_organization' => 'organizations#like_unlike'
	put 'like_fundraise' => 'fundraises#like'
	put 'follow_fundraise' => 'fundraises#follow'
	put 'like_campaign' => 'campaigns#like'
	put 'follow_campaign' => 'campaigns#follow'
	put 'like_cause' => 'causes#like'
	put 'follow_cause' => 'causes#follow'
	post 'organization_invitation' => 'organizations#organization_invitation'
	post 'accept_organization' => 'organizations#accept_organization'
	get  'organization_friend' => 'organizations#friend'
	post 'organization_invite' => 'organizations#organization_invite'
	post 'job_status' => 'jobs#job_status'
	get 'notification' => 'pages#notification'
	get 'my_fundraises' => 'fundraises#my_fundraise'
	put 'fundraise_status' => 'fundraises#fundraise_status'
	get 'chat_rooms/:id/get_messages' => 'messages#get_messages'
	#resources :friendships
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
