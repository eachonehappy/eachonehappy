class FundraisesController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :my_fundraise, :create]
	def index
    if params[:search]
      @fundraises = Fundraise.all.sort_by(&:created_at).reverse
      @fundraises = @fundraises.where("subject LIKE ?" , "%#{params[:search]}%")
    else
      @fundraises = Fundraise.all.sort_by(&:created_at).reverse
    end
  @payment = Payment.new  
  end
  
  def show
    @payment = Payment.new
    @fundraise = Fundraise.find(params[:id]) 
  end
  
  def new
    @fundraise = Fundraise.new
    @all_causes = Cause.all
    @users = current_user.friends
  end
  
  def create
    @fundraise = Fundraise.new(fundraise_params)
    if params[:fundraise][:cause_ids].reject(&:empty?).present?	
    	params[:fundraise][:cause_ids].reject(&:empty?).each do |cause_id|
      @fundraise.cause_fundraises.build(:cause_id => cause_id)
      end
    	@fundraise.user_id = current_user.id
      if params[:fundraise][:user_id].reject(&:empty?).present?
        params[:fundraise][:user_id].reject(&:empty?).each do |user_id|
          @user = User.find(user_id)   
        @fundraise.mention!(@user)
        end
      end
      if @fundraise.save
        redirect_to @fundraise
      else
        @all_causes = Cause.all
        @users = current_user.friends
        render 'new'
      end
    else 
      flash[:failure] = "Select atleast 1 Cause"
      @all_causes = Cause.all
      @users = current_user.friends
      render 'new'
    end 
  end

  def edit
    @users = current_user.friends
    @fundraise = Fundraise.find(params[:id])
  end

  def update
    @fundraise = Fundraise.find(params[:id])
    @fundraise.subject = fundraise_params[:subject]
    if fundraise_params[:image].present?
      @fundraise.image = fundraise_params[:image]
    end  
    @fundraise.description = fundraise_params[:description]
    @fundraise.small_description = fundraise_params[:small_description]
    if params[:fundraise][:user_id].reject(&:empty?).present?
        params[:fundraise][:user_id].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
          unless @fundraise.mentions?(@user)
            @fundraise.mention!(@user)
          end
        end
      end
  
    if @fundraise.save
      redirect_to @fundraise
    else
      render 'edit'
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
      params.require(:fundraise).permit(:subject, :target, :cause_ids, :small_description, :description, :image)
    end
end
