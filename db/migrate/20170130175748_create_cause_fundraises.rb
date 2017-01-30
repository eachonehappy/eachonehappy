class CreateCauseFundraises < ActiveRecord::Migration[5.0]
  def change
    create_table :cause_fundraises do |t|
    	t.integer :cause_id
    	t.integer :fundraise_id

      t.timestamps
    end
  end
end
