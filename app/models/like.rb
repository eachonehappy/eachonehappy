class Like < Socialization::ActiveRecordStores::Like
	include PublicActivity::Model
  tracked
	tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
after_create :update_wallet

  def update_wallet
    if self.likeable_type == "Fundraise"
			@fundraise = Fundraise.find(self.likeable_id)
			@user = @fundraise.user
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save
		elsif self.likeable_type == "Post"
			@post = Post.find(self.likeable_id)
			@user = @post.user
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save
		elsif self.likeable_type == "Cause"
			@cause = Cause.find(self.likeable_id)
			@user = @cause.user
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save	
	  end	
  end
end
