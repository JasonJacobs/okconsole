class SwitchForeignIdForImages < ActiveRecord::Migration
  def change
    add_column(:images, :post_id, :integer)
    remove_column(:posts, :image_id)
  end
end
