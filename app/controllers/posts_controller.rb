class PostsController < ApplicationController
  before_action :authenticate_user!
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
    @post.user_id = current_user.id
    @post.subject = "test"
    params[:post][:user_id].reject(&:empty?).each do |user_id|
      @user = User.find(user_id)
    @post.mention!(@user)
    end
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to posts_path
  end

  def post_like
    @post = Post.find(params[:post_id])
    if current_user.likes?(@post)
      if current_user.unlike!(@post)
        flash[:success] = "post created!"
        redirect_to root_path
      else
        render 'new'
      end
    else
      if current_user.like!(@post)
        flash[:success] = "post created!"
        redirect_to root_path
      else
        render 'new'
      end
    end
  end
  
  private
    
    def post_params
      params.require(:post).permit(:subject, :description, :image)
    end
end
