class AddSocializationColumnToOrganizations < ActiveRecord::Migration[5.0]
  def change
  	add_column :organizations, :followers_count, :integer, :default => 0
  	add_column :organizations, :likers_count, :integer, :default => 0
  end
end
