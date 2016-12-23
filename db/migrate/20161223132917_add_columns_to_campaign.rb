class AddColumnsToCampaign < ActiveRecord::Migration[5.0]
  def change
  	add_column :campaigns, :small_description, :string
  	add_column :campaigns, :image, :string
  end
end
