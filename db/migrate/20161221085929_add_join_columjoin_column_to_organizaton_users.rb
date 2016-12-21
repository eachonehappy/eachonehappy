class AddJoinColumjoinColumnToOrganizatonUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :organization_users, :role, :string
  	add_column :organization_users, :status, :string
  end
end
