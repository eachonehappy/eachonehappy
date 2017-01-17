class AddColumnToFundraisePaymentDetails < ActiveRecord::Migration[5.0]
  def change
  	add_column :fundraise_payment_details, :amount_to_be_paid, :integer
  end
end
