class FundraisesController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :my_fundraise]
	def index
    if params[:search]
      @fundraises = Fundraise.all
      @fundraises = @fundraises.where("subject LIKE ?" , "%#{params[:search]}%")
    else
      @fundraises = Fundraise.all
    end
  @payment = Payment.new  
  end
  
  def show
    @payment = Payment.new
    @fundraise = Fundraise.find(params[:id]) 
  end
  
  def new
    @fundraise = Fundraise.new
    @all_campaign = Campaign.all
    @users = User.all
  end
  
  def create
  	@fundraise = Fundraise.new(fundraise_params)
  	@fundraise.campaign_id = fundraise_params[:campaign_id]
  	@fundraise.user_id = current_user.id
    params[:fundraise][:user_id].reject(&:empty?).each do |user_id|
      @user = User.find(user_id)   
    @fundraise.mention!(@user)
    end
    if @fundraise.save
      flash[:success] = "fundraise created!"
      redirect_to fundraises_path
    else
      redirect_to new_fundraise_path
    end
  end
  
  def destroy
    Fundraise.find(params[:id]).destroy
    flash[:success] = "Fundraise deleted"
    redirect_to fundraises_path
  end

  def my_fundraise
    @my_fundraises = current_user.fundraises
    @payment = Payment.new 
  end

  def fundraise_status
    @fundraise = Fundraise.find(params[:format])
    if @fundraise.payment_is_pending
      @fundraise.payment_is_pending = false
      @fundraise.save
       if request.xhr?
        render json: { id: params[:format] }
      else
        redirect_to request.referer_path
      end   
    end  
  end

  def follow
    @fundraise = Fundraise.find(params[:format])
    if current_user.follows?(@fundraise)
      if current_user.unfollow!(@fundraise)
        if request.xhr?
          @fundraise = Fundraise.find(params[:format])
          render json: { count: @fundraise.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    else
      if current_user.follow!(@fundraise)
        if request.xhr?
          @fundraise = Fundraise.find(params[:format])
          render json: { count: @fundraise.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

  def like
    @fundraise = Fundraise.find(params[:format])
    if current_user.likes?(@fundraise)
      if current_user.unlike!(@fundraise)
        if request.xhr?
          @fundraise = Fundraise.find(params[:format])
          render json: { count: @fundraise.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end    
      else
        render 'new'
      end
    else
      if current_user.like!(@fundraise)
        if request.xhr?
          @fundraise = Fundraise.find(params[:format])
          render json: { count: @fundraise.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end
  
  private
    
    def fundraise_params
      params.require(:fundraise).permit(:subject, :target, :campaign_id, :small_description, :description, :image)
    end
end
