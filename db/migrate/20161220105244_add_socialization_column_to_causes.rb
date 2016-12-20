class AddSocializationColumnToCauses < ActiveRecord::Migration[5.0]
  def change
  	add_column :causes, :followers_count, :integer, :default => 0
  	add_column :causes, :likers_count, :integer, :default => 0
  end
end
