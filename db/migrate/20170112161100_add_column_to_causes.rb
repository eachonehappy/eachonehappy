class AddColumnToCauses < ActiveRecord::Migration[5.0]
  def change
  	add_column :causes, :user_id, :integer
  end
end
