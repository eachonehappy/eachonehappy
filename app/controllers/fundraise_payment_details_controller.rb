class FundraisePaymentDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
  before_action :user_admin, only: [:index, :show ]
	def index
		if params[:format].present?
      if params[:format] == "pending"
        @fundraise_payment_details = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => true})
        @fundraise_payment_details = @fundraise_payment_details.sort_by(&:created_at).reverse
      elsif params[:format] == "transfered"
        @fundraise_payment_details = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => false})
        @fundraise_payment_details = @fundraise_payment_details.sort_by(&:created_at).reverse
      else 
        @fundraise_payment_details = FundraisePaymentDetail.all
        @fundraise_payment_details = @fundraise_payment_details.sort_by(&:created_at).reverse
      end    
    else
      @fundraise_payment_details = FundraisePaymentDetail.all.sort_by(&:created_at).reverse
    end
    @posts_likes = Post.all.map(&:likers_count).inject(0, :+) 
    @campaigns_likes = Campaign.all.map(&:likers_count).inject(0, :+) 
    @campaigns_followers = Campaign.all.map(&:followers_count).inject(0, :+)
    @causes_likes = Cause.all.map(&:likers_count).inject(0, :+) 
    @causes_followers = Cause.all.map(&:followers_count).inject(0, :+)
    @fundraises_likes = Fundraise.all.map(&:likers_count).inject(0, :+) 
    @fundraises_followers = Fundraise.all.map(&:followers_count).inject(0, :+)
    @user_likes = User.all.map(&:followers_count).inject(0, :+)
    @organizations_followers = Organization.all.map(&:followers_count).inject(0, :+)
    @organizations_likers = Organization.all.map(&:likers_count).inject(0, :+)
    @total_amount = @posts_likes + @campaigns_likes + @campaigns_followers + @causes_likes + @causes_followers + @fundraises_likes + @fundraises_followers + @user_likes + @organizations_followers + @organizations_likers  
    @stat = Stat.first
    @total_amount = @total_amount*@stat.rate
  end

  def show
    @fundraise_payment_detail = FundraisePaymentDetail.find(params[:id])
  end

  def new
    @fundraise_payment_detail = FundraisePaymentDetail.new
    @all_fundraises = current_user.fundraises
    @fundraise = Fundraise.find(params[:format])
  end

  def create
    @fundraise_payment_detail = FundraisePaymentDetail.new(fundraise_payment_detail_params)
    if @fundraise_payment_detail.save
    	@fundraise = Fundraise.find(fundraise_payment_detail_params[:fundraise_id])
    	@fundraise.payment_is_pending = true
    	@fundraise.save
      flash[:success] = 'Chat room added!'
      redirect_to my_fundraises_path
    else
      render 'new'
    end
  end

  private

  def user_admin
  	redirect_to root_path unless current_user.admin
  end

  def fundraise_payment_detail_params
    params.require(:fundraise_payment_detail).permit(:full_name, :account_number, :ifsc_code, :fundraise_id)
  end
end
