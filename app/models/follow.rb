class Follow < Socialization::ActiveRecordStores::Follow
  include PublicActivity::Model
  tracked
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil }
  after_create :update_wallet

  def update_wallet
    if self.followable_type == "Fundraise"
			@fundraise = Fundraise.find(self.followable_id)
			@user = @fundraise.user
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save
		elsif self.followable_type == "User"
			@user = User.find(self.followable_id)
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save
		elsif self.followable_type == "Cause"
			@cause = Cause.find(self.followable_id)
			@user = @cause.user
			@stat_rate = Stat.first.rate
			@user.wallet_amount = @user.wallet_amount + @stat_rate
			@user.save	
	  end	
  end
end
