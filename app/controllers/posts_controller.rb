class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
	def index
    @posts = []
    @friends = current_user.friends
    @friends.each do |friend|
      friend.posts.each do |post|
        @posts << post
      end  
    end
  end
  
  def show
    @post = Post.find(params[:id]) 
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    if post_params[:description].present? || post_params[:image].present?
    	@post = Post.new(post_params)
      @post.user_id = current_user.id
      if params[:post][:user_id].reject(&:empty?).present?
        params[:post][:user_id].reject(&:empty?).each do |user_id|
          @user = User.find(user_id)
        @post.mention!(@user)
        end  
      end
      if @post.save
        redirect_to request.referer
      else
        redirect_to request.referer
      end
    else
      flash[:failure] = "Enter description or Upload image"
      redirect_to request.referer  
    end  
  end

  def edit
    @post = Post.find(params[:id])
    @all_user = User.all
  end
  
  def update
    @post = Post.find(params[:id])
    if params[:post][:user_id].reject(&:empty?).present?
      @post.mentionees(User).each do |user|
        @post.unmention!(user)
      end  
      params[:post][:user_id].reject(&:empty?).each do |user_id|
        @user = User.find(user_id)
      @post.mention!(@user)
      end
    end
    @post.image = post_params[:image]
    @post.description = post_params[:description]
    if @post.save
      redirect_to root_url
    else
      render 'edit'
    end
  end
  
  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = "Post deleted"
    redirect_to posts_path
  end

  def post_like
    @post = Post.find(params[:format])
    if current_user.likes?(@post)
      if current_user.unlike!(@post)
        if request.xhr?
          @post = Post.find(params[:format])
          render json: { count: @post.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end    
      else
        render 'new'
      end
    else
      if current_user.like!(@post)
        if request.xhr?
          @post = Post.find(params[:format])
          render json: { count: @post.likers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end
  
  private
    
    def post_params
      params.require(:post).permit(:description, :image)
    end
end
