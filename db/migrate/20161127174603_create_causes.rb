class CreateCauses < ActiveRecord::Migration[5.0]
  def change
    create_table :causes do |t|
    	t.string  :subject
    	t.text    :description
    	t.integer :organization_id
      t.timestamps
    end
  end
end
