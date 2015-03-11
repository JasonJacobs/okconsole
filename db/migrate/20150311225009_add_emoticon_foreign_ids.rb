class AddEmoticonForeignIds < ActiveRecord::Migration
  def change
    add_column(:posts, :emoticon_id, :integer)
  end
end
