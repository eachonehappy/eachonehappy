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
  
  private
    
    def organization_params
      params.require(:organization).permit(:name, :cause_ids)
    end
end
