class CreateCampaignUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :campaign_users do |t|
    	t.integer :campaign_id
    	t.integer :user_id

      t.timestamps
    end
  end
end
