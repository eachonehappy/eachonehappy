class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  $message = Message.new
  $chat_rooms = @current_user
  
  def messages
    @user = User.find(params[:friend_id])
    @a = @user.chat_rooms
    @b = current_user.chat_rooms
    @chat_room = @a & @b
    $chat_room_messages = @chat_room.first.messages
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :notice => 'sign in or signup'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
end
