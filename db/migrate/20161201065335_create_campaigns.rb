class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
    	t.string  :subject
    	t.text    :description
    	t.integer :organization_id
    	t.integer :cause_id
      t.timestamps
    end
  end
end
