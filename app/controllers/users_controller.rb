class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
  def index
    @users = User.all - [current_user] - current_user.friends
  end

  def new 
  end
  def show
    @comment = Comment.new
    @user = User.find(params[:id])
    @posts = @user.posts
    @users = @user.friends - [current_user]
    @payment = Payment.new 
    @all_user = @user.friends
    @organization_ids = current_user.organization_users.send_by_owner.map(&:organization_id) 
    @pending_organizations = Organization.where( id: @organization_ids) 
  end

  def edit
    @user = User.find(params[:format])
  end

  def update
    @user = User.find(params[:id])
    if params[:user]    
      if params[:user][:full_name].present?
        @user.full_name = params[:user][:full_name]
      elsif params[:user][:cover_image].present?
        @user.cover_image = params[:user][:cover_image]
      elsif params[:user][:profile_image].present?
        @user.profile_image = params[:user][:profile_image]
      else
        redirect_to request.referer 
      end
      if @user.save
        redirect_to @user
      else
        render 'edit'
      end
    else
      flash[:failure] = "select atleast one picture"
      redirect_to request.referer 
    end
  end

  def invite_friend
  	@user = User.find(params[:format])
    if current_user.friend_request @user
      flash[:success] = "Freind request send"
      if request.xhr?
        @user = User.find(params[:format])
        render json: { count: @user.requested_friends.count , id: params[:format] }
      else
        redirect_to request.referer_path
      end
    else
    	flash[:failure] = "Freind request not send"
      redirect_to request.referer
    end 
  end

  def accept_friend
    @user = User.find(params[:format])
    if current_user.accept_request @user
      @chat_room = current_user.chat_rooms.build(:title => "title" , :friend_id => params[:format])
      @chat_room.save
      @chat_room_user1 = @chat_room.chat_room_users.build(:user_id => params[:format])
      @chat_room_user1.save
      @chat_room_user2 = @chat_room.chat_room_users.build(:user_id => current_user.id)
      @chat_room_user2.save
      flash[:success] = "You are freinds"
      if request.xhr?
        @user = User.find(params[:format])
        render json: { count: "You are Freinds Now" , id: params[:format]}
      else
        redirect_to request.referer_path
      end
    else
      flash[:failure] = "U r not freinds"
      redirect_to request.referer
    end  
  end
  def decline_friend
    @user = User.find(params[:format])
    current_user.decline_request @user
    if request.xhr?
      @user = User.find(params[:format])
      render json: { count: "You are not freinds" , id: params[:format] }
    else
      redirect_to request.referer_path
    end
  end

  def remove_friend
    @user = User.find(params[:format])
    if current_user.remove_friend @user
      flash[:success] = "U r freinds"
      if request.xhr?
        @user = User.find(params[:format])
        render json: { count: @user.requested_friends.count , id: params[:format] }
      else
        redirect_to request.referer_path
      end
    else
      redirect_to request.referer
    end  
  end

  def follow_unfollow   
    @user = User.find(params[:format])
    if current_user.follows?(@user)
      if current_user.unfollow!(@user)
        if request.xhr?
          @user = User.find(params[:format])
          render json: { count: @user.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    else
      if current_user.follow!(@user)
        if request.xhr?
          @user = User.find(params[:format])
          render json: { count: @user.followers_count , id: params[:format] }
        else
          redirect_to request.referer_path
        end
      else
        render 'new'
      end
    end
  end

end
