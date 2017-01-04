class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit]
	def index
  end

  def show

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
