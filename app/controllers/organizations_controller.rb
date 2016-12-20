class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @organizations = Organization.all
  end
  
  def show
    @organization = Organization.find(params[:id]) 
  end
  
  def new
    @organization = Organization.new
    @all_causes = Cause.all
    @cause_organization = @organization.cause_organizations.build
  end
  
  def create
  	@organization = Organization.new(organization_params)
  	@organization.organization_users.build(:user_id => current_user.id)
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
    @organization = Organization.find(params[:organization_id])
    if current_user.follows?(@organization)
      if current_user.unfollow!(@organization)
        flash[:success] = "user created!"
        redirect_to request.referer
      else
        render 'new'
      end
    else
      if current_user.follow!(@organization)
        flash[:success] = "organization created!"
        redirect_to request.referer
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
    @organization = Organization.find(params[:organization_id])
    if current_user.likes?(@organization)
      if current_user.unlike!(@organization)
        flash[:success] = "organization created!"
        redirect_to @organization
      else
        render 'new'
      end
    else
      if current_user.like!(@organization)
        flash[:success] = "organization created!"
        redirect_to @organization
      else
        render 'new'
      end
    end
  end
  
  private
    
    def organization_params
      params.require(:organization).permit(:name, :cause_ids)
    end
end
