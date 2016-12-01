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
  end
  
  def create
  	@job = Job.new(job_params)
  	@job.campaign_id = params[:campaign][:id]
  	@job.job_users.build(:user_id => current_user.id)
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
      params.require(:job).permit(:subject, :description, :campaign)
    end
end
