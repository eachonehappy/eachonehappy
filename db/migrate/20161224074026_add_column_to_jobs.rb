class AddColumnToJobs < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :is_completed, :boolean, :default => false
  end
end
