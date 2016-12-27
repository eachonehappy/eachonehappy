class AddMissingIndexesNew < ActiveRecord::Migration[5.0]
  def change
  	add_index :payments, :user_id
    add_index :payments, :fundraise_id
    add_index :fundraise_payment_details, :fundraise_id
  end
end
