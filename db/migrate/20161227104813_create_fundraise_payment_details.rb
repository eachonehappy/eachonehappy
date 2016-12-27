class CreateFundraisePaymentDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :fundraise_payment_details do |t|
    	t.string  :full_name 
    	t.integer :account_number 
    	t.string  :ifsc_code 
    	t.integer :fundraise_id
    

      t.timestamps
    end
  end
end
