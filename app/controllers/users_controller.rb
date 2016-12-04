class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.reject { |u| u.id == current_user.id }
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
