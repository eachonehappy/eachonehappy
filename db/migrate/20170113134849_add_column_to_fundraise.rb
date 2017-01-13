class AddColumnToFundraise < ActiveRecord::Migration[5.0]
  def change
  	add_column :fundraises, :reedemed_amount, :integer, :default => 0
  end
end
