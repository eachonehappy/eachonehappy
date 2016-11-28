class CreateCauseUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :cause_users do |t|
      t.integer :cause_id
      t.integer :user_id
      t.timestamps
    end
  end
end
