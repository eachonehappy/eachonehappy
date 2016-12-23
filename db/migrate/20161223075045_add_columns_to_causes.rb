class AddColumnsToCauses < ActiveRecord::Migration[5.0]
  def change
  	add_column :causes, :small_description, :string
  	add_column :causes, :image, :string
  end
end
