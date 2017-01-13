class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_activities, only: [:index, :show, :new, :edit, :create]
	def index
  end

  def show

  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.chat_room_id = params[:chat_room_id]
    if @message.save
      @chat_room = ChatRoom.find(params[:chat_room_id])
      respond_to do |format|
        format.html { redirect_to request.referer }
        format.js 
        end
      else
        redirect_to request.referer
    end
  end

  def get_messages
    @chat_room = ChatRoom.find(params[:id])
    respond_to do |format|
      format.js 
      end
  end

  private

    def message_params
      params.require(:message).permit(:body, :chat_room_id)
    end
end
