class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
    	t.string 	  :subject
    	t.description :text
    	t.integer     :user_id
      t.timestamps
    end
  end
end
