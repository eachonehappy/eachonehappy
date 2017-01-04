class PaymentsController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
	def index
    @payments = current_user.payments
  end
  
  def show
    @payment = Payment.find(params[:id]) 
  end
  
  def new
    @payment = Payment.new
  end
  
  def create
  	@payment = Payment.new(payment_params)
  	@payment.user_id = current_user.id
  	@payment.fundraise_id = params[:fundraise_id]
    @fundraise = Fundraise.find(params[:fundraise_id])
    unless payment_params[:amount].to_f > current_user.wallet_amount
	    if @payment.save
	    	current_user.wallet_amount = current_user.wallet_amount - @payment.amount
	    	current_user.save
        @fundraise.raised_amount = @fundraise.raised_amount + @payment.amount
        @fundraise.save 
	      redirect_to request.referer
	    else
	      render 'new'
	    end
	  else
	  	redirect_to request.referer
	  end  
  end
  
  def destroy
    Payment.find(params[:id]).destroy
    redirect_to request.referer
  end
  
  private
    
    def payment_params
      params.require(:payment).permit(:amount, :fundraise_id, :user_id)
    end
end
