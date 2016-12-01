class ChangeFundraiseColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :fundraises, :cause_id, :campaign_id
  end
end
