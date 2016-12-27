class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
    	t.float :amount
    	t.integer :fundraise_id
    	t.integer :user_id

      t.timestamps
    end
  end
end
