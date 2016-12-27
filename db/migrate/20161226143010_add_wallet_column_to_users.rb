class AddWalletColumnToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :wallet_amount, :float, default: 0
  	add_column :users, :notification_count , :integer, default: 0
  end
end
