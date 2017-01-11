class CampaignsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
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
    @fundraises = @campaign.fundraises
    @payment = Payment.new
  end
  
  def new
    @campaign = Campaign.new
    @all_causes = Cause.all
    @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
    @users = current_user.friends
  end
  
  def create
    @campaign = Campaign.new(campaign_params)
    if campaign_params[:organization_id].present? && campaign_params[:cause_id].present?
    	@campaign.organization_id = campaign_params[:organization_id]
    	@campaign.cause_id = campaign_params[:cause_id]
    	@campaign.campaign_users.build(:user_id => current_user.id)
      if params[:campaign][:user_ids].reject(&:empty?).present?
        params[:campaign][:user_ids].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
        @campaign.mention!(@user)
        end
      end
      if @campaign.save
        redirect_to @campaign
      else
        @all_causes = Cause.all
        @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
        @users = current_user.friends
        render 'new'
      end
    else
      flash[:failure] = "Select One Organization & One Cause"
      @all_causes = Cause.all
      @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
      @users = current_user.friends
      render 'new' 
    end   
  end

  def edit
    @users = current_user.friends
    @campaign = Campaign.find(params[:id])
  end

  def update
    @campaign = Campaign.find(params[:id])
    @campaign.subject = campaign_params[:subject]
    @campaign.description = campaign_params[:description]
    @campaign.small_description = campaign_params[:small_description]
    @campaign.image = campaign_params[:image]
    if params[:campaign][:user_ids].reject(&:empty?).present?
        params[:campaign][:user_ids].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
          unless @campaign.mentions?(@user)
            @campaign.mention!(@user)
          end
        end
      end
  
    if @campaign.save
      redirect_to @campaign
    else
      render 'edit'
    end
  end
  
  def destroy
    Campaign.find(params[:id]).destroy
    flash[:success] = "Campaign deleted"
    redirect_to campaigns_path
  end

  def follow
    @campaign = Campaign.find(params[:format])
    if current_user.follows?(@campaign)
      if current_user.unfollow!(@campaign)
        if request.xhr?
          @campaign = Campaign.find(params[:format])
          render json: { count: @campaign.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    else
      if current_user.follow!(@campaign)
        if request.xhr?
          @campaign = Campaign.find(params[:format])
          render json: { count: @campaign.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

  def like
    @campaign = Campaign.find(params[:format])
    if current_user.likes?(@campaign)
      if current_user.unlike!(@campaign)
        if request.xhr?
          @campaign = Campaign.find(params[:format])
          render json: { count: @campaign.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end    
      else
        render 'new'
      end
    else
      if current_user.like!(@campaign)
        if request.xhr?
          @campaign = Campaign.find(params[:format])
          render json: { count: @campaign.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end
  
  private
    
    def campaign_params
      params.require(:campaign).permit(:subject, :description, :cause_id, :organization_id, :small_description, :image)
    end
end
