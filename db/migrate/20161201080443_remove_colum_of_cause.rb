class RemoveColumOfCause < ActiveRecord::Migration[5.0]
  def change
  	remove_column :causes, :organization_id
  end
end
