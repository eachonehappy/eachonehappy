class CausesController < ApplicationController
	before_action :authenticate_user!
	def index
    @causes = Cause.all
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
  
  private
    
    def cause_params
      params.require(:cause).permit(:subject, :description)
    end
end
