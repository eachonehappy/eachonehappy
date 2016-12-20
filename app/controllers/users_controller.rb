class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.reject { |u| u.id == current_user.id }
    @chat_room = current_user.chat_rooms
    # @friends = []

     #@chat_rooms.each do |chat|
      #   chat.users.each do |user|
       #      @friends << user
        # end
     #end
  end

  def new
    @message = Message.new
    
  end
  def show
    @comment = Comment.new
    @user = User.find(params[:id])
    @posts = @user.posts
    
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:cover_image].present?
      @user.cover_image = params[:user][:cover_image]
    end
    
    if params[:user][:profile_image].present? 
      @user.profile_image = params[:user][:profile_image]
    end
      
    if @user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def invite_friend
  	@user = User.find(params[:friend_id])
    if current_user.friend_request @user
      flash[:success] = "Freind request send"
      redirect_to users_path
    else
    	flash[:failure] = "Freind request not send"
      redirect_to users_path
    end  
  end

  def accept_friend
    @user = User.find(params[:friend_id])
    if current_user.accept_request @user
      @chat_room = current_user.chat_rooms.build(:title => "title" , :friend_id => params[:friend_id])
      @chat_room.save
      @chat_room_user1 = @chat_room.chat_room_users.build(:user_id => params[:friend_id])
      @chat_room_user1.save
      @chat_room_user2 = @chat_room.chat_room_users.build(:user_id => current_user.id)
      @chat_room_user2.save
      flash[:success] = "U r freinds"
      redirect_to users_path
    else
      flash[:failure] = "U r not freinds"
      redirect_to users_path
    end  
  end

  def remove_friend
    @user = User.find(params[:friend_id])
    if current_user.remove_friend @user
      flash[:success] = "U r freinds"
      redirect_to users_path
    else
      flash[:failure] = "U r not freinds"
      redirect_to users_path
    end  
  end

  def follow_unfollow   
    @user = User.find(params[:user_id])
    if current_user.follows?(@user)
      if current_user.unfollow!(@user)
        flash[:success] = "user created!"
        redirect_to @user
      else
        render 'new'
      end
    else
      if current_user.follow!(@user)
        flash[:success] = "post created!"
        redirect_to @user
      else
        render 'new'
      end
    end
  end

end
