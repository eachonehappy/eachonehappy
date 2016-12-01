class ChangeJobColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :jobs, :cause_id, :campaign_id
  end
end
