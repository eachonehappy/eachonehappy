class JobsController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
	def index
    @user_jobs = current_user.jobs
    
    if params[:format].present?
      if params[:format] == "all"
        @jobs = @user_jobs.sort_by(&:created_at).reverse
      elsif params[:format] == "completed"
        @jobs = @user_jobs.select { |job| job.is_completed == true }
        @jobs = @jobs.sort_by(&:created_at).reverse
      else 
        @jobs = @user_jobs.select { |job| job.is_completed == false }
        @jobs = @jobs.sort_by(&:created_at).reverse
      end    
    else
      @jobs = @user_jobs.sort_by(&:created_at).reverse
    end
  end
  
  def show
    @job = Job.find(params[:id]) 
  end
  
  def new
    @job = Job.new
    @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
    @all_campaign = []
    @all_organizations.each do |org|
      org.campaigns.each do |campaign|
        @all_campaign << campaign
      end
    end
    @all_user = current_user.friends + [current_user]
  end
  
  def create
    @job = Job.new(job_params)
    if job_params[:campaign_id].present? && params[:job][:user_ids].reject(&:empty?).present? 	
    	@job.campaign_id = job_params[:campaign_id]
      params[:job][:user_ids].reject(&:empty?).each do |user_id|
        @job.job_users.build(:user_id => user_id)
    end
    unless params[:job][:user_ids].reject(&:empty?).include? "#{current_user.id}"
      @job.job_users.build(:user_id => current_user.id)
    end
      if @job.save
        redirect_to jobs_path
      else
        @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
        @all_campaign = []
        @all_organizations.each do |org|
          org.campaigns.each do |campaign|
            @all_campaign << campaign
          end
        end
        @all_user = current_user.friends + [current_user]
        render 'new'
      end
    else
      flash[:failure] = "Select Campaign and to Whom job Assigned"
      @all_organizations = current_user.organizations.joins(:organization_users).where(:organization_users => {:status => "accepted"})
      @all_campaign = []
      @all_organizations.each do |org|
        org.campaigns.each do |campaign|
          @all_campaign << campaign
        end
      end
      @all_user = current_user.friends + [current_user]
      render 'new'
    end  
  end

  def edit
    @all_user = current_user.friends + [current_user]
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @job.subject = job_params[:subject]
    @job.description = job_params[:description]
    if params[:job][:user_ids].present?
        params[:job][:user_ids].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
          unless @job.users.include?(@user)
            @job.job_users.build(:user_id => user_id)
          end
        end
      end
  
    if @job.save
      redirect_to jobs_path
    else
      render 'edit'
    end
  end
  
  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job deleted"
    redirect_to jobs_path
  end

  def job_status
    @job = Job.find(params[:job_id])
    @job.toggle!(:is_completed)
    redirect_to request.referer
  end
  
  private
    
    def job_params
      params.require(:job).permit(:subject, :description, :campaign_id)
    end
end
