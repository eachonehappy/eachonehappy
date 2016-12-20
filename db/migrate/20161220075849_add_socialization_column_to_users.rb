class AddSocializationColumnToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :followers_count, :integer, :default => 0
  end
end
