class CausesController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
	def index
    if params[:search]
      @causes = Cause.all
      @causes = @causes.where("subject LIKE ?" , "%#{params[:search]}%")
    else
      @causes = Cause.all
    end
  end
  
  def show
    @cause = Cause.find(params[:id]) 
  end
  
  def new
    @cause = Cause.new
  end
  
  def create
  	@cause = Cause.new(cause_params)
    if @cause.save
      flash[:success] = "cause created!"
      redirect_to causes_path
    else
      render 'new'
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
