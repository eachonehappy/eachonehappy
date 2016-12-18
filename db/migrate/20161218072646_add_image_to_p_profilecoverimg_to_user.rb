class AddImageToPProfilecoverimgToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :profile_image, :string
  	add_column :users, :cover_image, :string
  end
end
