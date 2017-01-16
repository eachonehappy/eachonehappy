class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_action :user_activity
  include PublicActivity::StoreController
  
  def load_activities
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id})
    @activities = @activities.reject{|activity| activity.key == "like.destroy" }
    @activities = @activities.reject{|activity| activity.key == "follow.destroy" }
    #@activities = []
    #@all_activities.each do |activity|
    #  @friendship = HasFriendship::Friendship.where(friendable_id: activity.owner, friend_id: current_user.id).first
    #  @friendship_reverse = HasFriendship::Friendship.where(friendable_id: activity.owner, friend_id: current_user.id).first
    #  if @friendship
    #    @activities << activity if @friendship.created_at < activity.created_at
    #  elsif @friendship_reverse
    #    @activities << activity if @friendship_reverse.created_at < activity.created_at
    #  end
    #end
    @posts_likes = current_user.posts.map(&:likers_count).inject(0, :+) 
    @campaigns_likes = current_user.campaigns.map(&:likers_count).inject(0, :+) 
    @campaigns_followers = current_user.campaigns.map(&:followers_count).inject(0, :+)
    @causes_likes = current_user.causes.map(&:likers_count).inject(0, :+) 
    @causes_followers = current_user.causes.map(&:followers_count).inject(0, :+)
    @fundraises_likes = current_user.fundraises.map(&:likers_count).inject(0, :+) 
    @fundraises_followers = current_user.fundraises.map(&:followers_count).inject(0, :+)
    @user_likes = current_user.followers_count
    @user_organizations = current_user.organizations.select { |org| org.organization_users.where(user_id: current_user.id).where(role: "owner") }
    @organizations_followers = @user_organizations.map(&:followers_count).inject(0, :+)
    @organizations_likers = @user_organizations.map(&:likers_count).inject(0, :+)
    @sum_count = @posts_likes + @campaigns_likes + @campaigns_followers + @causes_likes + @causes_followers + @fundraises_likes + @fundraises_followers + @user_likes + @organizations_followers + @organizations_likers

    if @sum_count > current_user.notification_count
      @stat = Stat.first
      @amount_to_be_added =  (@sum_count - current_user.notification_count)*@stat.rate
      current_user.notification_count = @sum_count     
      current_user.wallet_amount = current_user.wallet_amount + @amount_to_be_added
      current_user.save
    end 
    
    @activities = @activities.last(20)
    @chat_rooms = current_user.chat_rooms
    @messages = []
    @chat_rooms.each do |chat_room|
      chat_room.messages.each do |message|
        unless message.user == current_user
          @messages << message
        end
      end
    end  
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  private

	def user_activity
	  current_user.try :touch
	end
end
