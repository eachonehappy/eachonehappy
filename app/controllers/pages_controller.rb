class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:notification]
  before_action :load_activities, only: [:notification]
  

  def home
    if user_signed_in?
    	@post = Post.new
    	@comment = Comment.new
      @payment = Payment.new
      @posts = []
      @friends = current_user.friends + [current_user]
      @friends.each do |friend|
        friend.posts.each do |post|
          @posts << post
        end  
      end
    	@posts = @posts.sort_by(&:created_at).reverse
      if @posts.empty?
        @posts = Post.all.sort_by(&:likers_count).sort_by(&:created_at).last(20).reverse
      end
    	@all_user = current_user.friends
      @fundraises = Fundraise.all.sort_by(&:likers_count).sort_by(&:created_at).last(20).reverse
      @campaigns = Campaign.all.sort_by(&:likers_count).sort_by(&:created_at).last(20).reverse
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
    @major_causes = Cause.all.sort_by(&:likers_count).last(11)
  end

  def about_us
  end

  def contact_us
    @contact = Contact.new
  end

  def our_goal
    
  end

  def volunteer_us
    
  end

  def notification
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id})
  end
end
