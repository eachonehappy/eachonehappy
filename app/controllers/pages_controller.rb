class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:home, :about_us, :cantact_us]

  def home
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
    @fundraises = Fundraise.all.sort_by(&:likers_count).sort_by(&:created_at).last(1).reverse
    @campaigns = Campaign.all.sort_by(&:likers_count).sort_by(&:created_at).last(20).reverse
  end

  def about_us
  end

  def contact_us
  end

  def notification
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id}).all
  end
end
