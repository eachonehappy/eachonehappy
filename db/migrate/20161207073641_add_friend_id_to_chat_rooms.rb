class AddFriendIdToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :friend_id, :integer
  end
end
