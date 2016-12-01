class CampaignsController < ApplicationController
  before_action :authenticate_user!
	def index
    @campaigns = Campaign.all
  end
  
  def show
    @campaign = Campaign.find(params[:id]) 
  end
  
  def new
    @campaign = Campaign.new
    @all_causes = Cause.all
    @all_organizations = Organization.all
  end
  
  def create
  	@campaign = Campaign.new(campaign_params)
  	@campaign.organization_id = params[:organization][:id]
  	@campaign.cause_id = params[:cause][:id]
  	@campaign.campaign_users.build(:user_id => current_user.id)
    if @campaign.save
      flash[:success] = "campaign created!"
      redirect_to campaigns_path
    else
      render 'new'
    end
  end
  
  def destroy
    Campaign.find(params[:id]).destroy
    flash[:success] = "Campaign deleted"
    redirect_to campaigns_path
  end
  
  private
    
    def campaign_params
      params.require(:campaign).permit(:subject, :description, :cause, :organization)
    end
end
