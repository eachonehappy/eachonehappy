class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.float :rate
      t.timestamps
    end
  end
end