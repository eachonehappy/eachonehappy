class CommentsController < ApplicationController
	before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
	def index
    #@comments = Comment.all
  end
  
  def show
    @comment = Comment.find(params[:id]) 
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
  	@comment = Comment.new(comment_params)
    if params[:comment][:user_id].reject(&:empty?).present?
      params[:comment][:user_id].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
      @comment.mention!(@user)
      end  
    end
  	@comment.post_id = params[:post_id]
  	@comment.user_id = current_user.id
    if @comment.save
      @post = @comment.post
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js 
      end
      
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

