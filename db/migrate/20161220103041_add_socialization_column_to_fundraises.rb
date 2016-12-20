class AddSocializationColumnToFundraises < ActiveRecord::Migration[5.0]
  def change
  	add_column :fundraises, :followers_count, :integer, :default => 0
  	add_column :fundraises, :likers_count, :integer, :default => 0
  end
end
