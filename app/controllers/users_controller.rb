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
end
