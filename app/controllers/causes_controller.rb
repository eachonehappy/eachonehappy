class CausesController < ApplicationController
	before_action :authenticate_user!
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
    @cause = Cause.find(params[:cause_id])
    if current_user.follows?(@cause)
      if current_user.unfollow!(@cause)
        flash[:success] = "user created!"
        redirect_to request.referer
      else
        render 'new'
      end
    else
      if current_user.follow!(@cause)
        flash[:success] = "cause created!"
        redirect_to request.referer
      else
        render 'new'
      end
    end
  end

  def like
    @cause = Cause.find(params[:cause_id])
    if current_user.likes?(@cause)
      if current_user.unlike!(@cause)
        flash[:success] = "cause created!"
        redirect_to @cause
      else
        render 'new'
      end
    else
      if current_user.like!(@cause)
        flash[:success] = "cause created!"
        redirect_to @cause
      else
        render 'new'
      end
    end
  end
  
  private
    
    def cause_params
      params.require(:cause).permit(:subject, :description)
    end
end
