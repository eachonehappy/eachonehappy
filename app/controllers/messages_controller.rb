class MessagesController < ApplicationController
	def index
  #  @user = User.find(params[:friend_id])
   # @a = @user.chat_rooms
  #  @b = current_user.chat_rooms
   # @chat_room = @a & @b
   # @chat_room_messages = @chat_room.first.messages
   # redirect_to chat_rooms_path
  end

  def show
   # byebug
  end

  def create
    message = Message.new(message_params)
    message.user = current_user
    message.chat_room_id = params[:chat_room_id]
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.body,
        user: message.user.first_name
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:body, :chat_room_id)
    end
end
