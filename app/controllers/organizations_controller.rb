class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
  def index
    if params[:search]
      @organizations = Organization.all
      @organizations = @organizations.where("name LIKE ?" , "%#{params[:search]}%")
    else
      @organizations = Organization.all
    end
  end
  
  def show
    @comment = Comment.new
    @organization = Organization.find(params[:id])
    @pending_requests_ids = @organization.organization_users.send_by_user.map(&:user_id) 
    @pending_users = User.where( id: @pending_requests_ids)
    @members_ids = @organization.organization_users.accepted.map(&:user_id) 
    @members = User.where( id: @members_ids)
    @organization_posts = []
    @members.each do |member|
      member.posts.each do |post|
        @organization_posts << post
      end  
    end
    @campaigns =  @organization.campaigns
    @organization_fundraise = []
    @campaigns.each do |campaign|
      campaign.fundraises.each do |fundraise|
        @organization_fundraise << fundraise
      end  
    end  
  end
  
  def new
    @organization = Organization.new
    @all_causes = Cause.all
    @cause_organization = @organization.cause_organizations.build
  end
  
  def create
  	@organization = Organization.new(organization_params)
  	@organization.organization_users.build(:user_id => current_user.id, :role=>"owner",:status=>"accepted")
  	params[:organization][:cause_ids].reject(&:empty?).each do |cause|
      @cause_id = Cause.find_by_subject(cause).id
    @organization.cause_organizations.build(:cause_id => @cause_id)
    end
    if @organization.save 
      flash[:success] = "organization created!"
      redirect_to organizations_path
    else
      render 'new'
    end
  end
  
  def destroy
    Organization.find(params[:id]).destroy
    flash[:success] = "Organization deleted"
    redirect_to organizations_path
  end

  def follow
    @organization = Organization.find(params[:format])
    if current_user.follows?(@organization)
      if current_user.unfollow!(@organization)
        if request.xhr?
          @organization = Organization.find(params[:format])
          render json: { count: @organization.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    else
      if current_user.follow!(@organization)
        if request.xhr?
          @organization = Organization.find(params[:format])
          render json: { count: @organization.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

  def update
    @organization = Organization.find(params[:id])
    if params[:organization][:cover_image].present?
      @organization.cover_image = params[:organization][:cover_image]
    end
    
    if params[:organization][:profile_image].present? 
      @organization.profile_image = params[:organization][:profile_image]
    end
      
    if @organization.save
      flash[:success] = "Profile updated"
      redirect_to @organization
    else
      render 'edit'
    end
  end

  def like_unlike
    @organization = Organization.find(params[:format])
    if current_user.likes?(@organization)
      if current_user.unlike!(@organization)
        if request.xhr?
          @organization = Organization.find(params[:format])
          render json: { count: @organization.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end    
      else
        render 'new'
      end
    else
      if current_user.like!(@organization)
        if request.xhr?
          @organization = Organization.find(params[:format])
          render json: { count: @organization.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

  def organization_invitation
    @organization = Organization.find(params[:organization_id])
    if current_user.organization_users.where(:organization_id => @organization.id).where(:status=>"accepted").present?
      @organization.organization_users.where(:user_id => current_user.id).first.destroy
      redirect_to request.referer
    elsif current_user.organization_users.where(:organization_id => @organization.id).where(:status=>"send_by_owner").present?
      @organization_user = OrganizationUser.where(:user_id => current_user.id).where(:organization_id=>@organization.id).first
      @organization_user.status = "accepted"
      @organization_user.save 
      redirect_to request.referer
      else
      @organization.organization_users.build(:user_id => current_user.id, :role=>"coworker",:status=>"send_by_user") 
      @organization.save
      redirect_to request.referer
    end
  end

  def accept_organization
    @organization_user = OrganizationUser.where(:organization_id => params[:organization_id]).where(:user_id => params[:user_id])
    @organization_user = @organization_user.first
    @organization_user.status = "accepted"
    @organization_user.save
    redirect_to request.referer
  end

  def friend
    @organization_id = params[:organization_id]
    @users = User.all
  end

  def organization_invite
    @organization = Organization.find(params[:organization_id])
    @organization.organization_users.build(:user_id => params[:user_id], :role=>"coworker",:status=>"send_by_owner")    
    @organization.save
    redirect_to request.referer
  end
  
  private
    
    def organization_params
      params.require(:organization).permit(:name, :cause_ids, :description,:profile_image)
    end
end
