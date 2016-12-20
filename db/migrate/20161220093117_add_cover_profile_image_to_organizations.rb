class AddCoverProfileImageToOrganizations < ActiveRecord::Migration[5.0]
  def change
  	add_column :organizations, :profile_image, :string
  	add_column :organizations, :cover_image, :string
  end
end
