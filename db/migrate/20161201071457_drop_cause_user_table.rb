class DropCauseUserTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :cause_users
  end
end
