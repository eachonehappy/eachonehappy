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
  	@fundraise.campaign_id = fundraise_params[:campaign_id]
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

  def follow
    @fundraise = Fundraise.find(params[:fundraise_id])
    if current_user.follows?(@fundraise)
      if current_user.unfollow!(@fundraise)
        flash[:success] = "user created!"
        redirect_to request.referer
      else
        render 'new'
      end
    else
      if current_user.follow!(@fundraise)
        flash[:success] = "fundraise created!"
        redirect_to request.referer
      else
        render 'new'
      end
    end
  end

  def like
    @fundraise = Fundraise.find(params[:fundraise_id])
    if current_user.likes?(@fundraise)
      if current_user.unlike!(@fundraise)
        flash[:success] = "fundraise created!"
        redirect_to @fundraise
      else
        render 'new'
      end
    else
      if current_user.like!(@fundraise)
        flash[:success] = "fundraise created!"
        redirect_to @fundraise
      else
        render 'new'
      end
    end
  end
  
  private
    
    def fundraise_params
      params.require(:fundraise).permit(:subject, :target, :campaign_id)
    end
end
