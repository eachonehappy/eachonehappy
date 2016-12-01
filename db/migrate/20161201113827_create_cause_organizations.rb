class CreateCauseOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :cause_organizations do |t|
    	t.integer :cause_id
    	t.integer :organization_id

      t.timestamps
    end
  end
end
