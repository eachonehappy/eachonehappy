class AddMissingIndexes < ActiveRecord::Migration[5.0]
  def change
  	add_index :friendships, [:friendable_id, :friendable_type]
    add_index :friendships, :friend_id
    add_index :organization_users, :organization_id
    add_index :organization_users, :user_id
    add_index :jobs, :campaign_id
    add_index :chat_room_users, :chat_room_id
    add_index :chat_room_users, :user_id
    add_index :cause_organizations, :cause_id
    add_index :cause_organizations, :organization_id
    add_index :campaigns, :organization_id
    add_index :campaigns, :cause_id
    add_index :campaign_users, :campaign_id
    add_index :campaign_users, :user_id
    add_index :comments, :user_id
    add_index :comments, :post_id
    add_index :fundraises, :campaign_id
    add_index :fundraises, :user_id
    add_index :job_users, :job_id
    add_index :job_users, :user_id
    add_index :posts, :user_id
end
end
