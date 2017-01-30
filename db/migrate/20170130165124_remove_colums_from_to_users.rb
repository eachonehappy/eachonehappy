class RemoveColumsFromToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :user_type, :string
  	remove_column :users, :first_name, :string
  	remove_column :users, :last_name, :string
  end
end
