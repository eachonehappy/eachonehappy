class CausesController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
	def index
    if params[:search]
      @causes = Cause.all.sort_by(&:created_at).reverse
      @causes = @causes.where("subject LIKE ?" , "%#{params[:search]}%")
    else
      @causes = Cause.all.sort_by(&:created_at).reverse
    end
  end
  
  def show
    @cause = Cause.find(params[:id])
    @organizations = @cause.organizations
    @campaigns = @cause.campaigns 
  end
  
  def new
    @cause = Cause.new
  end
  
  def create
  	@cause = Cause.new(cause_params)
    @cause.user_id = current_user.id
    if @cause.save
      flash[:success] = "cause created!"
      redirect_to @cause
    else
      render 'new'
    end
  end

  def edit
    @cause = Cause.find(params[:id])
  end

  def update
    @cause = Cause.find(params[:id])
    @cause.subject = cause_params[:subject]
    @cause.image = cause_params[:image]
    @cause.description = cause_params[:description]
    @cause.small_description = cause_params[:small_description]
  
    if @cause.save
      redirect_to @cause
    else
      render 'edit'
    end
  end
  
  def destroy
    Cause.find(params[:id]).destroy
    flash[:success] = "Cause deleted"
    redirect_to causes_path
  end

  def follow
    @cause = Cause.find(params[:format])
    if current_user.follows?(@cause)
      if current_user.unfollow!(@cause)
        if request.xhr?
          @cause = Cause.find(params[:format])
          render json: { count: @cause.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    else
      if current_user.follow!(@cause)
        if request.xhr?
          @cause = Cause.find(params[:format])
          render json: { count: @cause.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

  def like
    @cause = Cause.find(params[:format])
    if current_user.likes?(@cause)
      if current_user.unlike!(@cause)
        if request.xhr?
          @cause = Cause.find(params[:format])
          render json: { count: @cause.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end    
      else
        render 'new'
      end
    else
      if current_user.like!(@cause)
        if request.xhr?
          @cause = Cause.find(params[:format])
          render json: { count: @cause.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end
  
  private
    
    def cause_params
      params.require(:cause).permit(:subject, :description, :small_description, :image)
    end
end
