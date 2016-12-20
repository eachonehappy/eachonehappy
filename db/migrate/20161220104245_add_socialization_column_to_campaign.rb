class AddSocializationColumnToCampaign < ActiveRecord::Migration[5.0]
  def change
  	add_column :campaigns, :followers_count, :integer, :default => 0
  	add_column :campaigns, :likers_count, :integer, :default => 0
  end
end
