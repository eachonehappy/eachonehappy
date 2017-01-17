class AddColumnToFundraisePaymentDetailsNew < ActiveRecord::Migration[5.0]
  def change
  	remove_column :fundraise_payment_details, :account_number, :integer
  	add_column :fundraise_payment_details, :account_number, :string
  end
end
