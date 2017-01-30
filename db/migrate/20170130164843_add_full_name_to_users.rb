class AddFullNameToUsers < ActiveRecord::Migration[5.0]
  def change
  add_column :users, :full_name, :string
  execute <<-SQL
    UPDATE users SET full_name = first_name||' '||last_name WHERE full_name IS NULL;
  SQL
  end
end
