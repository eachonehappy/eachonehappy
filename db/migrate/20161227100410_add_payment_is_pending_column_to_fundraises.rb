class AddPaymentIsPendingColumnToFundraises < ActiveRecord::Migration[5.0]
  def change
  	add_column :fundraises, :payment_is_pending , :boolean, default: nil
  end
end
