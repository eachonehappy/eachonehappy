class AddMissingIndexes2 < ActiveRecord::Migration[5.0]
  def change
    add_index :friendships, [:friendable_id, :friend_id]
    add_index :friendships, [:friend_id, :friendable_id]
    add_index :causes, :user_id
  end
end
