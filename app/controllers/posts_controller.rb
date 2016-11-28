class PostsController < ApplicationController
	def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id]) 
  end
  
  def new
    @post = Post.new
  end
  
  def create
  	@post = Post.new(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to posts_path
  end
  
  private
    
    def post_params
      params.require(:post).permit(:subject, :description)
    end
end
