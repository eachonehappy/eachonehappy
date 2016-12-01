class DropCategoryOrganizationTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :category_organizations
  end
end
