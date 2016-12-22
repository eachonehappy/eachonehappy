class CampaignsController < ApplicationController
  before_action :authenticate_user!
	def index
    if params[:search]
      @campaigns = Campaign.all
      @campaigns = @campaigns.where("subject LIKE ?" , "%#{params[:search]}%")
    else
      @campaigns = Campaign.all
    end
  end
  
  def show
    @campaign = Campaign.find(params[:id]) 
  end
  
  def new
    @campaign = Campaign.new
    @all_causes = Cause.all
    @all_organizations = Organization.all
    @users = User.all
  end
  
  def create
  	@campaign = Campaign.new(campaign_params)
  	@campaign.organization_id = campaign_params[:organization_id]
  	@campaign.cause_id = campaign_params[:cause_id]
  	@campaign.campaign_users.build(:user_id => current_user.id)
    params[:campaign][:user_ids].reject(&:empty?).each do |user_id|
      @user = User.find(user_id)
    @campaign.mention!(@user)
    end
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

  def follow
    @campaign = Campaign.find(params[:campaign_id])
    if current_user.follows?(@campaign)
      if current_user.unfollow!(@campaign)
        flash[:success] = "user created!"
        redirect_to request.referer
      else
        render 'new'
      end
    else
      if current_user.follow!(@campaign)
        flash[:success] = "campaign created!"
        redirect_to request.referer
      else
        render 'new'
      end
    end
  end

  def like
    @campaign = Campaign.find(params[:campaign_id])
    if current_user.likes?(@campaign)
      if current_user.unlike!(@campaign)
        flash[:success] = "campaign created!"
        redirect_to @campaign
      else
        render 'new'
      end
    else
      if current_user.like!(@campaign)
        flash[:success] = "campaign created!"
        redirect_to @campaign
      else
        render 'new'
      end
    end
  end
  
  private
    
    def campaign_params
      params.require(:campaign).permit(:subject, :description, :cause_id, :organization_id)
    end
end
