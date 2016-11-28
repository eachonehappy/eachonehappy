class CreateCategoryOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :category_organizations do |t|
      t.integer :category_id
      t.integer :organization_id
      t.timestamps
    end
  end
end
