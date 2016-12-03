class CommentsController < ApplicationController
	before_action :authenticate_user!
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
  	@comment.post_id = 1
  	@comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "comment created!"
      redirect_to comments_path
    else
      render 'new'
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment deleted"
    redirect_to comments_path
  end
  
  private
    
    def comment_params
      params.require(:comment).permit(:description)
    end
end

