class UsersController < ApplicationController
  def index

    @users = User.all.reject { |u| u.id == current_user.id }
  end

  def invite_friend
  	@user = User.find(params[:friend_id])
    if current_user.invite @user
      flash[:success] = "Freind request send"
      redirect_to users_path
    else
    	flash[:failure] = "Freind request not send"
      redirect_to users_path
    end  
  end
end
