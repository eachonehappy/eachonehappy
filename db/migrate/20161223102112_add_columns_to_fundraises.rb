class AddColumnsToFundraises < ActiveRecord::Migration[5.0]
  def change
  	add_column :fundraises, :small_description, :string
  	add_column :fundraises, :description, :text
  	add_column :fundraises, :image, :string
  	add_column :fundraises, :raised_amount, :integer, :default => 0
  end
end
