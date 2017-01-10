class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:home, :about_us, :cantact_us]

  def home
  	@post = Post.new
  	@comment = Comment.new
    @payment = Payment.new
  	@posts = Post.all.sort_by(&:created_at).reverse
  	@all_user = current_user.friends
    @fundraises = Fundraise.all.sort_by(&:likers_count).reverse
    @campaigns = Campaign.all.sort_by(&:likers_count).reverse
  end

  def about_us
  end

  def contact_us
  end

  def notification
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_type: "User", owner_id: current_user.friends.map {|u| u.id}).all
  end
end
