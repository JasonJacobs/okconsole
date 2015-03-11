class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :top_copy
      t.string :bottom_copy
      t.integer :user_id
      t.integer :image_id
      t.integer :language_id

      t.timestamps null: false
    end
  end
end
