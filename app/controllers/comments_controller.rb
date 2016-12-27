class CommentsController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
	def index
    @comments = Comment.all
  end
  
  def show
    @comment = Comment.find(params[:id]) 
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
  	@comment = Comment.new(comment_params)
  	@comment.post_id = params[:post_id]
  	@comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to request.referer
    else
      render 'new'
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referer
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:description, :post_id)
    end
end

