class RemoveColumnFromPosts < ActiveRecord::Migration[5.0]
  def self.up
    remove_column :posts, :subject
  end

  def self.down
    add_column :posts, :subject, :string
  end
end
