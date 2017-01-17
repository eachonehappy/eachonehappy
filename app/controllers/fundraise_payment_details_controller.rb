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
    @total_wallet_amount = User.all.map(&:wallet_amount).inject(0, :+)
    @fundraises_payment_amount_to_be_paid = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => true}).map(&:amount_to_be_paid).inject(0, :+) 
    @fundraises_payment_amount_paid = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => false}).map(&:amount_to_be_paid).inject(0, :+) 
    @fundraises_amount = Fundraise.all.map(&:raised_amount).inject(0, :+)
    @total_amount = @total_wallet_amount + @fundraises_amount
  end

  def show
    @fundraise_payment_detail = FundraisePaymentDetail.find(params[:id])
  end

  def new
    @fundraise_payment_detail = FundraisePaymentDetail.new
    @all_fundraises = current_user.fundraises.where(payment_is_pending: nil)
    @fundraise = Fundraise.find(params[:format])
  end

  def create
    @fundraise_payment_detail = FundraisePaymentDetail.new(fundraise_payment_detail_params)
    @fundraise = Fundraise.find(fundraise_payment_detail_params[:fundraise_id])
    @fundraise_payment_detail.amount_to_be_paid = @fundraise.raised_amount
    if @fundraise_payment_detail.save
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
