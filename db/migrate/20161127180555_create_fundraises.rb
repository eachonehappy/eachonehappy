class CreateFundraises < ActiveRecord::Migration[5.0]
  def change
    create_table :fundraises do |t|
    	t.string  :subject
    	t.integer :target
    	t.integer :cause_id
    	t.integer :user_id
      t.timestamps
    end
  end
end
