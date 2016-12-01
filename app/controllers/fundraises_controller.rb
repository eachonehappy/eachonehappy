class FundraisesController < ApplicationController
	before_action :authenticate_user!
	def index
    @fundraises = Fundraise.all
  end
  
  def show
    @fundraise = Fundraise.find(params[:id]) 
  end
  
  def new
    @fundraise = Fundraise.new
    @all_campaign = Campaign.all
  end
  
  def create
  	@fundraise = Fundraise.new(fundraise_params)
  	@fundraise.campaign_id = params[:campaign][:id]
  	@fundraise.user_id = current_user.id
    if @fundraise.save
      flash[:success] = "fundraise created!"
      redirect_to fundraises_path
    else
      render 'new'
    end
  end
  
  def destroy
    Fundraise.find(params[:id]).destroy
    flash[:success] = "Fundraise deleted"
    redirect_to fundraises_path
  end
  
  private
    
    def fundraise_params
      params.require(:fundraise).permit(:subject, :target, :campaign)
    end
end
