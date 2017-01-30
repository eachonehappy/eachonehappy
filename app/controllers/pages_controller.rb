class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:notification]
  before_action :load_activities, only: [:notification, :home]
  

  def home
    if user_signed_in?
      @users = User.all - [current_user] - current_user.friends
      @suggested_friends = @users.sort_by(&:followers_count).last(10).reverse
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
      @posts_all = Post.all.sort_by(&:likers_count).first(30).reverse
    	@posts = @posts.sort_by(&:created_at).sort_by(&:likers_count).reverse + @posts_all
      @posts = @posts.uniq{|x| x.id}.sort_by(&:created_at).reverse
       
    	@all_user = current_user.friends
      @fundraises = Fundraise.all.sort_by(&:created_at).sort_by(&:likers_count).last(10).reverse
      #@campaigns = Campaign.all.sort_by(&:created_at).sort_by(&:likers_count).last(10).reverse
    
    end
    @major_causes = Cause.all.sort_by(&:likers_count).last(10)
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

  def privacy_policy
    
  end

  def notification
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id})
    @activities = @activities.reject{|activity| activity.key == "like.destroy" }
    @activities = @activities.reject{|activity| activity.key == "follow.destroy" }
  end
end
