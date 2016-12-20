class JobsController < ApplicationController
	before_action :authenticate_user!
	def index
    @jobs = Job.all
  end
  
  def show
    @job = Job.find(params[:id]) 
  end
  
  def new
    @job = Job.new
    @all_campaign = Campaign.all
    @all_user = User.all
  end
  
  def create
  	@job = Job.new(job_params)
  	@job.campaign_id = job_params[:campaign_id]
  	@job.job_users.build(:user_id => current_user.id)
    params[:job][:user_ids].reject(&:empty?).each do |user_id|
      @user = User.find(user_id)
    @job.mention!(@user)
    end
    if @job.save
      flash[:success] = "job created!"
      redirect_to jobs_path
    else
      render 'new'
    end
  end
  
  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job deleted"
    redirect_to jobs_path
  end
  
  private
    
    def job_params
      params.require(:job).permit(:subject, :description, :campaign_id)
    end
end
