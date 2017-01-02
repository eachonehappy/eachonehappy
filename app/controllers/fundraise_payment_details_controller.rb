class FundraisePaymentDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
  before_action :user_admin, only: [:index, :show ]
	def index
		if params[:format].present?
      if params[:format] == "pending"
        @fundraise_payment_details = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => true})
      elsif params[:format] == "transfered"
        @fundraise_payment_details = FundraisePaymentDetail.joins(:fundraise).where(:fundraises => {:payment_is_pending => false})
      else 
        @fundraise_payment_details = FundraisePaymentDetail.all
      end    
    else
      @fundraise_payment_details = FundraisePaymentDetail.all
    end
  end

  def show
    @fundraise_payment_detail = FundraisePaymentDetail.find(params[:id])
  end

  def new
    @fundraise_payment_detail = FundraisePaymentDetail.new
    @all_fundraises = current_user.fundraises
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