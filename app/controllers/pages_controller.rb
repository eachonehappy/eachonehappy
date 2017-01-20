class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:notification]
  before_action :load_activities, only: [:notification, :home]
  

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
  end
end
